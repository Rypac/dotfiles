#!/bin/sh
#
# Update all apps and tools

if command -v brew >/dev/null 2>&1; then
    brew update
    brew upgrade
    brew bundle
    brew cleanup --prune=all
fi

if command -v ghcup >/dev/null 2>&1; then
    ghcup gc
fi

if command -v cabal >/dev/null 2>&1; then
    cabal update
fi
