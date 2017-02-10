#!/usr/bin/env bash

set -e

: ${DOTFILES_HOME:="$HOME/.dotfiles"}

if type curl > /dev/null 2>&1; then
    fetch='curl -#L'
elif type wget > /dev/null 2>&1; then
    fetch='wget --no-check-certificate -O -'
else
    echo 'No command to fetch dotfiles' && exit 1
fi

mkdir -p "$DOTFILES_HOME"
eval "$fetch https://github.com/Rypac/dotfiles/tarball/master | tar -xz -C "$DOTFILES_HOME" --strip-components=1"
source "$DOTFILES_HOME/setup"

