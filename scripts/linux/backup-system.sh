#!/bin/sh

borg init /mnt/data/Linux/debian/backup
sudo borg create -C zlib,5 /mnt/data/Linux/debian/backup::root-{now:%Y-%m-%d} / \
    --exclude '/dev/*' \
    --exclude '/media/*' \
    --exclude '/mnt/*' \
    --exclude '/proc/*' \
    --exclude '/sys/*' \
    --exclude '/tmp/*' \
    --exclude '/etc/fstab' \
    --exclude '/var/run/*' \
    --exclude '/var/lock/*' \
    --exclude '/var/cache/apt/archives/*' \
    --one-file-system
