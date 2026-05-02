# XDG base directories
export XDG_BIN_HOME="$HOME/.local/bin"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"

# Configure zsh and dotfiles
ZDOTDIR="$XDG_CONFIG_HOME/zsh"
DOTFILES_HOME="$HOME/.dotfiles"

# Python
export PYTHON_HISTORY="$XDG_STATE_HOME/python_history"

# Homebrew
export HOMEBREW_BUNDLE_FILE="$DOTFILES_HOME/mac/Brewfile"

# SQLite
export SQLITE_HISTORY="$XDG_STATE_HOME/sqlite_history"
