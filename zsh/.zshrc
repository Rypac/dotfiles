# Interactive environment variables
export BROWSER=open
export EDITOR=nvim
export PAGER=less
export LESSHISTFILE=-

# Options
setopt inc_append_history

# Enable vi mode
bindkey -v
KEYTIMEOUT=1

# Keybindings
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search
bindkey '^P' up-line-or-search
bindkey '^N' down-line-or-search
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^F' forward-char
bindkey '^B' backward-char
bindkey '^[f' forward-word
bindkey '^[b' backward-word
bindkey '^K' kill-line
bindkey '^U' backward-kill-line
bindkey '^Y' yank
bindkey '^[^?' backward-kill-word
bindkey '^?' backward-delete-char

# Enable line editor
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line
bindkey -M vicmd '^V' edit-command-line

# Display keymap aware prompt
function zle-line-init zle-keymap-select {
    local mode='I'
    if [ "$KEYMAP" = vicmd ]; then
        mode='N'
    fi

    PROMPT="%F{blue}[$mode] %B%F{cyan}%1~%f%b %(?.%F{green}.%F{red})%(!.#.$)%f "
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

# Setup Homebrew shell environment
if [ -x /opt/homebrew/bin/brew ]; then
    source <(/opt/homebrew/bin/brew shellenv)

    fpath=("$HOMEBREW_PREFIX/share/zsh/site-functions" $fpath)
fi

# Enable completions
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

if (( $+commands[fzf] )); then
    source <(fzf --zsh)

    if (( $+commands[rg] )); then
        export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
    fi

    function preview() {
        if (( $+commands[bat] )); then
            fzf --preview 'bat --style=full --color=always {}'
        else
            fzf --preview 'cat {}'
        fi
    }
fi

if (( $+commands[zoxide] )); then
    source <(zoxide init zsh)
fi

if (( $+commands[pyenv] )); then
    path=("$PYENV_ROOT/shims" $path)
fi

# List directory contents
alias ls='ls -G'
alias ll='ls -lhF --color=auto'
alias la='ls -lahF --color=auto'

# Function abbreviations
alias f=finder
alias ql=quick-look
alias manp=man-preview

# Clear the clipboard
function pbclear() {
    printf '' | pbcopy
}

if (( $+commands[bat] )); then
    alias cat=bat
fi

if (( $+commands[lazygit] )); then
    alias lg=lazygit
fi

# Create a new directory and automatically naviate there
function mkcd() {
    mkdir -p "$@" && cd "$_"
}

# Open the given directories in Finder, or the current directory if empty
function finder() {
    open "${@:-.}" &>/dev/null
}

# View a file or directory in QuickLook.app
function quick-look() {
    (( $# > 0 )) && qlmanage -p $* &>/dev/null &
}

# View a man page in Preview.app
function man-preview() {
    mandoc -T pdf "$(/usr/bin/man -w $@)" | open -f -a Preview
}

# Remove .DS_Store files recursively in a directory, default .
function dspurge() {
    find "${@:-.}" -type f -name .DS_Store -print -delete
}

# Remove node_modules directories recursively in a directory, default .
function nmpurge() {
    find "${@:-.}" -type d -name node_modules -prune -print -exec rm -rI -- {} +
}

# Run a Haskell script in Cabal or Stack
function haskell-script() {
    if [ ! -f "$1" ]; then
        return 1
    fi

    case "$(head -1 "$1")" in
        '#!/usr/bin/env runghc')
            runghc "$@" ;;
        '#!/usr/bin/env runhaskell')
            runhaskell "$@" ;;
        '#!/usr/bin/env cabal'|'{- cabal:')
            cabal run -v0 "$@" ;;
        '#!/usr/bin/env stack')
            stack --silent "$@" ;;
        '-- stack script'*|'{- stack script'*)
            stack --silent =(cat <(echo '#!/usr/bin/env stack') "$1") "${@:2}" ;;
        *)
            runghc "$@" ;;
    esac
}

# Load plugins
for plugin (
    "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
    "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
); if [ -f "$plugin" ]; then
    source "$plugin"
else
    echo "Failed to load plugin $plugin"
fi

# Ensure local executable directory is first on path
path=("$XDG_BIN_HOME" $path)

# Source dotfiles management functions
source "$DOTFILES_HOME/dotfiles"

# Source local zshrc
if [ -r "$ZDOTDIR/.zshrc.local" ]; then
    source "$ZDOTDIR/.zshrc.local"
fi

# Remove duplicate entries from paths
typeset -U path manpath infopath
