#!/bin/sh

# dotfiles
update-dotfiles

# apt packages
sudo apt update
sudo apt upgrade

# non-tracked packages
local-packages update
local-packages install
i3-update

# rust
rustup update

# stack
stack --resolver nightly update
stack --resolver nightly upgrade

# npm
n-update -y
n stable
npm update -g

# python
pip3 list --outdated --user | cut -d ' ' -f 1 | xargs -n 1 pip3 install --upgrade --user

# vim
nvim +PlugUpgrade +PlugInstall +PlugUpdate +qall
