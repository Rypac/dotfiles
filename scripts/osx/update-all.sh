#!/usr/bin/env bash

# dotfiles
update-dotfiles

# brew packages
brew update
brew upgrade

# shell
fisher up

# non-tracked packages
"$XDG_DATA_HOME/fzf/install" --bin

# rust
rustup update
cargo install-update -a

# stack
stack --resolver nightly update
stack --resolver nightly upgrade

# npm
fnm lts
npm update -g
yarn global upgrade

# python
pip3 list --outdated | cut -d ' ' -f 1 | xargs -n 1 pip3 install --upgrade

# vim
nvim +PlugUpgrade +PlugInstall +PlugUpdate +qall

# atom
apm upgrade --no-confirm
