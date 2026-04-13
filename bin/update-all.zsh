#!/usr/bin/env zsh
#
# Update all apps and tools

if (($+commands[brew])); then
    brew update
    brew upgrade
    brew bundle
    brew cleanup --prune=all
fi

if (($+commands[uv])); then
    uv python upgrade
    uv tool upgrade --all
fi

if (($+commands[ghcup])); then
    ghcup gc
fi

if (($+commands[cabal])); then
    cabal update
fi
