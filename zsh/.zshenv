# XDG base directories
export XDG_BIN_HOME="$HOME/.local/bin"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"

# Configure zsh and dotfiles
ZDOTDIR="$XDG_CONFIG_HOME/zsh"
DOTFILES_HOME="$HOME/.dotfiles"

# Haskell
export GHCUP_USE_XDG_DIRS=1
export STACK_XDG=1

# Rust
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export CARGO_HOME="$XDG_DATA_HOME/cargo"

# Python
export PYENV_ROOT="$XDG_DATA_HOME/pyenv"

# Node
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NODE_REPL_HISTORY="$XDG_STATE_HOME/node_repl_history"

# Homebrew
export HOMEBREW_BUNDLE_FILE="$DOTFILES_HOME/mac/Brewfile"

# SQLite
export SQLITE_HISTORY="$XDG_STATE_HOME/sqlite_history"

# Source local zshenv
if [ -r "$ZDOTDIR/.zshenv.local" ]; then
    . "$ZDOTDIR/.zshenv.local"
fi
