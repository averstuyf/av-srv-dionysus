#!/bin/sh
VERSION="2"

SOURCES=(
    $HOME/downloads/plex/
    $HOME/downloads/bits/plex/
    )

for source in "${SOURCES[@]}"; do
    # Guard against the source directory not existing
    [ ! -d "$source" ] && continue

    echo "Processing, source: $source"
    
    # Move the source files
    # Note: Directories will be copied instead of moved
    rsync -r -e ssh --progress --remove-source-files --exclude-from='exclude-on-move.txt' "$source" arnaud@192.168.86.11:/srv/media/        

    # Delete the empty source directories
    find "$source" -depth -type d -empty -delete
done
