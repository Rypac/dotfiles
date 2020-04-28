# dotfiles

This is a collection of the configuration and preferences I use to personalise my system.

If you don't already backup and synchronise your dotfiles, you should! It's simple to do and makes sharing your system config across various machines or other with people a breeze. GitHub [has a very nice website](https://dotfiles.github.io) which explains the process in greater detail and links to some terrific dotfile resources and examples.

**NOTE:** The [`install`](install) script will not play nicely with existing dotfiles. It may overwrite some of your precious configuration. Use it either as a reference, or to holistically replace your own dotfiles. You have been warned!

## Installation

Simply run:

```sh
git clone https://github.com/Rypac/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install
```

This will symlink the dotfiles to their appropriate directories. The [`install`](install) script is idempotent so it can (and should) be run for any new dotfiles you decide to sync.

## Updating

Some handy scripts to keep these dotfiles up-to-date live in the [`bin`](bin) directory. Additionally, if these dotfiles are managed using the [`install`](install) script they will be linked to `~/.local/bin` and available on your `$PATH`.

To keep the dotfiles updated, run:

```sh
update-dotfiles
```