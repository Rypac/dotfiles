#!/bin/sh

dots="${1:-$HOME/.dotfiles}"

if [ -d "$dots" ]; then
    (cd "$dots" && git fetch --all && git pull && ./install)
else
    echo "Invalid directory" && exit 1
fi
