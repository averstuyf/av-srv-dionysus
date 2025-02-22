  GNU nano 5.4                                                      defrag-usb.sh                                                                
#!/bin/bash

# Ensure script runs as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root (use sudo)." >&2
    exit 1
fi

# Check arguments
if [[ $# -ne 2 ]]; then
    echo "Usage: $0 <device> <mount_point>"
    echo "Example: $0 /dev/sdX1 /mnt/mydrive"
    exit 1
fi

DEVICE="$1"
MOUNT_POINT="$2"

# Check if the device exists
if [[ ! -b "$DEVICE" ]]; then
    echo "Error: Device $DEVICE not found."
    exit 1
fi

# Check if the mount point exists
if [[ ! -d "$MOUNT_POINT" ]]; then
    echo "Error: Mount point $MOUNT_POINT does not exist."
    exit 1
fi

# Unmount the filesystem
echo "Unmounting $DEVICE from $MOUNT_POINT..."
umount "$DEVICE" || { echo "Failed to unmount $DEVICE. Is it in use?"; exit 1; }

systemctl stop udisks2.service

# Run filesystem check and optimize directories
echo "Running e2fsck on $DEVICE..."
e2fsck -f -p -D -v "$DEVICE"

systemctl start udisks2.service

# Remount the filesystem
echo "Remounting $DEVICE to $MOUNT_POINT..."
mount "$DEVICE" "$MOUNT_POINT" || { echo "Failed to mount $DEVICE. Check manually."; exit 1; }

# Run e4defrag
echo "Running e4defrag on $MOUNT_POINT..."
#stdbuf -oL e4defrag -v "$MOUNT_POINT"
stdbuf -oL e4defrag -v "$MOUNT_POINT" |
awk '
{
  # If the line does NOT contain "[ OK ]", print it.
  if (index($0, "[ OK ]") == 0) {
    print
    next
  }

  # If the line does NOT contain "extents:", print it.
  if (index($0, "extents:") == 0) {
    print
    next
  }

  split($0, parts, "extents:")
  if (length(parts) < 2) {
    print
    next
  }

  split(parts[2], extParts, "->")
  if (length(extParts) < 2) {
    print
    next

	}

  n = split(extParts[1], leftFields, " ")
  left = ""
  for (i = 1; i <= n; i++) {
    if (leftFields[i] != "")
      left = leftFields[i]
  }

  n = split(extParts[2], rightFields, " ")
  right = (n > 0 ? rightFields[1] : "")

  if (left > right) {
    print
    next
  }
}
'

echo "Optimization and defragmentation complete."
