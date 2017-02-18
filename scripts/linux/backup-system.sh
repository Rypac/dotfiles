#!/usr/bin/env bash

repo="${1:-/mnt/storage/Linux/Backups}"

borg init "$repo"
borg create -C zlib,5 "$repo"::{hostname}-{user}-{now:%Y-%m-%d} ~ --exclude '~/.cache'
borg prune --keep-within=1w --keep-weekly=4 "$repo"
