# macOS

This contains macOS specific configuration. The majority of these are applied automatically with the [`install`](../install) script however the themes must be applied manually as per the instructions below.

## Homebrew

All software that can be installed in an automated way is managed by [Homebrew].

The list of apps and utilities are defined in [Brewfile](./Brewfile) and managed automatically using [`brew bundle`][bundle]. This will install and upgrade all formulae listed in the Brewfile.

This Brewfile should act as the canonical list of all software installed on the system. If something is installed or removed manually, the Brewfile can be kept up to date with the system by generating and overwriting the file stored in this directory using:

```shell
brew bundle dump
```

## Launch Agents

Launch Agents are background tasks which run in the context of an interactive user session.

All of the `.plist` files in the [LaunchAgents](./LaunchAgents) directory will be automatically symlinked into the `~/Library/LaunchAgents` directory.

## Services

Services are actions that appear in the `Services` menu.

All of the `.workflow` files in [Services](./Services) will be automatically symlinked into the `~/Library/Services` directory.

## Terminal

Profiles for Terminal.app must be installed manually, and can be activated using the following steps:

1. _Terminal > Preferences > Profiles_
2. Click _"Gear"_ icon
3. Click _Import…_
4. Select the [`Mariana.terminal`](./Terminal/Mariana.terminal) file
5. Click _Default_

<!-- Links -->
[bundle]: https://github.com/Homebrew/homebrew-bundle
[dracula-terminal]: https://draculatheme.com/terminal
[dracula-terminal-download]: https://github.com/dracula/terminal-app/archive/master.zip
[dracula-xcode]: https://draculatheme.com/xcode
[dracula-xcode-download]: https://github.com/dracula/xcode/archive/master.zip
[Homebrew]: https://brew.sh
