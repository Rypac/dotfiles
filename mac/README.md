# macOS

This contains macOS specific configuration. The majority of these are applied automatically with the [`install`](../install) script however the themes must be applied manually as per the instructions below.

## Homebrew

All software that can be installed in an automated way is managed by [Homebrew] and [`mas`][mas].

The list of apps and utilities are defined in [Brewfile](./Brewfile) and managed automatically using [`brew bundle`][bundle]. This will install and upgrade all formulae, casks and App Store apps listed in the Brewfile.

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

## Themes

Application themes are not managed automatically as adding and updating are typically a manual process. The steps to update these themes are listed below.

### Terminal

[Dracula][dracula-terminal] terminal theme.

#### Installation

Download using the [GitHub .zip download][dracula-terminal-download] option and unzip.

#### Activation

1. _Terminal > Preferences > Profiles_
2. Click _"Gear"_ icon
3. Click _Import…_
4. Select the `Dracula.terminal` file
5. Click _Default_

### Xcode

[Dracula][dracula-xcode] Xcode theme.

#### Installation

1. Download using the [GitHub .zip download][dracula-xcode-download] option and unzip.
2. Create the custom themes folder:

    ```shell
    mkdir -p ~/Library/Developer/Xcode/UserData/FontAndColorThemes
    ```

3. Move `Dracula.xccolortheme` file to this custom themes folder.

#### Activation

1. _Xcode > Preferences > Themes_
2. Select the Dracula theme

<!-- Links -->
[bundle]: https://github.com/Homebrew/homebrew-bundle
[dracula-terminal]: https://draculatheme.com/terminal
[dracula-terminal-download]: https://github.com/dracula/terminal-app/archive/master.zip
[dracula-xcode]: https://draculatheme.com/xcode
[dracula-xcode-download]: https://github.com/dracula/xcode/archive/master.zip
[Homebrew]: https://brew.sh
[mas]: https://github.com/mas-cli/mas
