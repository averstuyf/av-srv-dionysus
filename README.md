# Arnaud Verstuyf, Dionysus server

Dionysus serves house.

# Set up server

## Install firmware

```shell
apt-get install firmware-linux-nonfree
```

## Install ssh

## Install rsync

```shell
sudo apt-get install rsync
```

## Fix problem with host name

```shell
nano /etc/hostname
nano /etc/hosts
```

Add: 127.0.0.1 \<hostname> \<hostname without domain>

```shell
reboot
```

## Install Docker

- https://docs.docker.com/engine/install/debian/

Install using the repository.

## Install Docker Compose

- https://docs.docker.com/compose/install/

## Make Plex directories accessible to scp

```shell
arnaud@dionysus:~$ sudo mkdir /var/lib/plex
arnaud@dionysus:~$ sudo mkdir /var/tmp/plex
arnaud@dionysus:~$ sudo mkdir /srv/media
arnaud@dionysus:~$ sudo chown -R arnaud /var/lib/plex/
arnaud@dionysus:~$ sudo chown -R arnaud /var/tmp/plex
arnaud@dionysus:~$ sudo chown -R arnaud /srv/media
```

# Perform maintenance

## Change hostname

- https://linuxize.com/post/how-to-change-hostname-on-debian-10/

```shell
sudo hostnamectl set-hostname \<hostname>
nano /etc/hosts
reboot
```

## Update Debian

```shell
sudo apt-get update && sudo apt-get dist-upgrade
```

It is possible that Docker requires switching to the newest version after updating. See the installation documentation.

## Secure copy to/from server

- https://upcloud.com/community/tutorials/secure-linux-cloud-server/

```shell
# Copy the file "foo.txt" from the local host to a remote host
scp foo.txt <username>@<remotehost>:/some/remote/directory

# Copy the file "foo.txt" from a remote host to the local host
scp <username>@<remotehost>:foo.txt /some/local/directory
```

## Start and stop Docker Compose

```shell
sudo docker-compose up -d
sudo docker-compose down
```

## Cleaning up Docker

> https://vsupalov.com/cleaning-up-after-docker/

```shell
sudo docker system prune
```

## Defrag ext4

```shell
sudo e4defrag /
```

## License

This repository is [licensed](LICENSE.md) under the permissive MIT License.

---

Copyright (c) 2020 [Arnaud Verstuyf](https://github.com/averstuyf)
