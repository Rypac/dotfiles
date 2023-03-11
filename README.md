# dotfiles

This is a collection of the configuration and preferences I use to personalise my system.

If you don't already backup and synchronise your dotfiles, you should! It's simple to do and makes sharing your system config across various machines or other with people a breeze. GitHub [has a very nice guide](https://dotfiles.github.io) that explains the process in greater detail and links to some terrific dotfile resources and examples.

**NOTE:** The [`dotfiles`](./dotfiles) script will _not_ play nicely with existing dotfiles. It may overwrite some of your precious configuration. Use it either as a reference, or to holistically replace your own dotfiles. You have been warned!

## Installation

Simply run:

```sh
git clone https://github.com/Rypac/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./dotfiles link
```

This will symlink the dotfiles to their appropriate directories. The `dotfiles link` command is idempotent so it can (and should) be run for any new dotfiles you decide to sync.
