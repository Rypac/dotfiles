#!/usr/bin/env bash

# dotfiles
update-dotfiles

# brew packages
brew update
brew upgrade

# shell
fish -c 'fisher up'

# non-tracked packages
"$XDG_DATA_HOME/fzf/install" --bin

# rust
rustup update
cargo install-update -a

# stack
stack --resolver nightly update
stack --resolver nightly upgrade

# npm
fish -c 'fnm use lts'
npm update -g
yarn global upgrade

# python
pip3 list --outdated --format=legacy | cut -d ' ' -f 1 | xargs -n 1 pip3 install --upgrade

# vim
nvim +PlugInstall +PlugUpdate +PlugClean! +PlugUpgrade +qall

# atom
apm upgrade --no-confirm
