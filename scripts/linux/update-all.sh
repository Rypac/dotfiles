#!/usr/bin/env bash

# dotfiles
update-dotfiles

# apt packages
sudo apt update
sudo apt upgrade -y

# fzf
"$XDG_DATA_HOME/fzf/install" --bin

# rust
rustup update
cargo install-update -a

# stack
stack --resolver nightly update
stack --resolver nightly upgrade

# npm
n-update -y
n stable
npm update -g
yarn global upgrade

# python
pip3 list --outdated --user | cut -d ' ' -f 1 | xargs -n 1 pip3 install --upgrade --user

# vim
nvim +PlugUpgrade +PlugInstall +PlugUpdate +qall

# atom
apm upgrade --no-confirm
