#!/bin/sh
# shellcheck source-path=SCRIPTDIR

: "${DOTFILES_HOME:="$HOME/.dotfiles"}"

dotfiles_link() {
    link() {
        target="$1"
        origin="$DOTFILES_HOME/$target"
        destination="$2"

        if [ -L "$destination" ]; then
            echo "Linking $target to $destination"
        elif [ -f "$destination" ]; then
            echo "WARNING: $destination already exists"
        elif [ -d "$destination" ]; then
            echo "WARNING: $destination already exists"
        else
            destination_parent="$(dirname "$destination")"

            if [ ! -d "$destination_parent" ]; then
                mkdir -p "$destination_parent"
            fi

            echo "Linking $target to $destination"

            ln -fns "$origin" "$destination"
        fi
    }

    link_contents() {
        target="$1"
        origin="$DOTFILES_HOME/$target"
        destination="$2"

        if [ ! -d "$destination" ]; then
            mkdir -p "$destination"
        fi

        echo "Linking $target/* to $destination"

        for f in "$origin"/*; do
            if [ -f "$f" ]; then
                name="$(basename "$f")"
                ln -fns "$f" "$destination/$name"
            fi
        done

        for d in "$origin"/*/; do
            if [ -d "$d" ]; then
                name="$(basename "$d")"
                ln -fns "$f" "$destination/$name"
            fi
        done
    }

    # Source XDG environment variables
    . "$DOTFILES_HOME/zsh/.zshenv"

    # Link executables
    link dotfiles.sh "$XDG_BIN_HOME/dotfiles"
    link bin/sqlite-to-json.sh "$XDG_BIN_HOME/sqlite-to-json"

    # Link common dotfiles
    link alacritty "$XDG_CONFIG_HOME/alacritty"
    link fourmolu/fourmolu.yaml "$XDG_CONFIG_HOME/fourmolu.yaml"
    link git "$XDG_CONFIG_HOME/git"
    link ghc "$XDG_CONFIG_HOME/ghc"
    link ideavim "$XDG_CONFIG_HOME/ideavim"
    link lazygit "$XDG_CONFIG_HOME/lazygit"
    link npm "$XDG_CONFIG_HOME/npm"
    link nvim "$XDG_CONFIG_HOME/nvim"
    link zsh "$XDG_CONFIG_HOME/zsh"
    link zsh/.zshenv "$HOME/.zshenv"

    # Link host-specific dotfiles
    if [ "$(uname)" = Linux ]; then
        link sublime-merge "$XDG_CONFIG_HOME/sublime-merge/Packages/User"
        link sublime-text "$XDG_CONFIG_HOME/sublime-text/Packages/User"
    elif [ "$(uname)" = Darwin ]; then
        link_contents mac/LaunchAgents "$HOME/Library/LaunchAgents"
        link_contents mac/Services "$HOME/Library/Services"
        link sublime-merge "$HOME/Library/Application Support/Sublime Merge/Packages/User"
        link sublime-text "$HOME/Library/Application Support/Sublime Text/Packages/User"
    fi
}

dotfiles_provision() {
    # Source environment variables
    . "$DOTFILES_HOME/zsh/.zshenv"
    . "$DOTFILES_HOME/zsh/.zprofile"

    # Bootstrap XDG directories
    for xdgdir in "$XDG_BIN_HOME" "$XDG_CONFIG_HOME" "$XDG_DATA_HOME" "$XDG_CACHE_HOME" "$XDG_STATE_HOME"; do
        mkdir -p "$xdgdir"
        chmod 0700 "$xdgdir"
    done

    # Create standard directories and fix permissions
    for dir in ~/.gnupg ~/.ssh; do
        mkdir -p "$dir"
        find "$dir" -type d -exec chmod 700 {} \;
        find "$dir" -type f -exec chmod 600 {} \;
    done

    # Remove last login message from new terminal sessions
    if [ ! -f ~/.hushlogin ]; then
        touch ~/.hushlogin
    fi

    if [ "$(uname)" = Darwin ]; then
        # Set preferences
        . "$DOTFILES_HOME/mac/preferences.sh"

        # Update Homebrew and install packages
        if command -v brew >/dev/null 2>&1; then
            brew update
            brew upgrade
            brew tap homebrew/bundle
            brew bundle --file="$DOTFILES_HOME/mac/Brewfile"
        else
            echo "Homebrew not installed. Visit: https://brew.sh"
        fi
    fi
}

dotfiles_environment() {
    . "$DOTFILES_HOME/zsh/.zshenv"
    . "$DOTFILES_HOME/zsh/.zprofile"

    if [ "$(uname)" = Darwin ]; then
        . "$DOTFILES_HOME/mac/environment.sh"
    fi
}

sourced=0
if [ -n "$ZSH_VERSION" ]; then
    case $ZSH_EVAL_CONTEXT in
        *:file) sourced=1 ;;
    esac
elif [ -n "$BASH_VERSION" ]; then
    (return 0 2>/dev/null) && sourced=1
else
    case ${0##*/} in
        sh | -sh | dash | -dash | ksh | -ksh) sourced=1 ;;
    esac
fi

if [ "$sourced" -eq 0 ]; then
    set -eu

    usage="usage: $(basename "$0") [link|provision|environment]"
    command="${1-}"

    case "$command" in
        link)
            dotfiles_link
            ;;
        provision)
            dotfiles_provision
            ;;
        environment)
            dotfiles_environment
            ;;
        -h | --help)
            echo "$usage"
            ;;
        *)
            echo "$usage" && exit 1
            ;;
    esac
else
    unset sourced
fi
