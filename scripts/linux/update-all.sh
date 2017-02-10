#!/usr/bin/env bash

# dotfiles
update-dotfiles

# apt packages
sudo apt update
sudo apt upgrade -y

# shell
fish -c 'fisher up'

# fzf
"$XDG_DATA_HOME/fzf/install" --bin

# rust
rustup update
cargo install-update -a

# stack
stack --resolver nightly update
stack --resolver nightly upgrade

# npm
fish -c 'fnm use latest'
npm update -g
yarn global upgrade

# python
pip3 list --outdated --user --format=legacy | cut -d ' ' -f 1 | xargs -n 1 pip3 install --upgrade --user

# vim
nvim +PlugInstall +PlugUpdate +PlugClean! +PlugUpgrade +qall

# atom
apm upgrade --no-confirm
