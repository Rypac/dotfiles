#!/usr/bin/env bash

: ${DOTFILES_HOME:="$HOME/.dotfiles"}

if [ -d "$DOTFILES_HOME" ]; then
    (cd "$DOTFILES_HOME" && git fetch --all && git pull && ./install)
else
    echo "Invalid directory" && exit 1
fi
