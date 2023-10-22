#! /bin/bash

su
    cp /etc/pacman.d/mirrorlist /home/sheldon/Desktop/pacman.mirrorlist.$(date +%Y%m%d).backup
    curl -s "https://archlinux.org/mirrorlist/?country=CA&country=US&country=DE&country=GB&protocol=https&use_mirror_status=on" | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -n 10 - > /etc/pacman.d/mirrorlist
exit