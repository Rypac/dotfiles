# Interactive environment variables
export BROWSER=open
export EDITOR=nvim
export VISUAL=nvim
export PAGER=less
export LESSHISTFILE=-

# Use a more readable grey for autosuggestions
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=243'

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
bindkey -M vicmd ' ' edit-command-line

# Display keymap aware prompt
function zle-line-init zle-keymap-select {
    local mode='%(!.#.$)'
    if [ "$KEYMAP" = vicmd ]; then
        mode=':'
    fi

    local userhost=''
    if [ -n "$SSH_CONNECTION" ]; then
        userhost='%F{cyan}%n@%m%f '
    fi

    PROMPT="${userhost}%F{blue}%1~%f %F{%(?.green.red)}$mode%f "

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
fi

if (( $+commands[zoxide] )); then
    source <(zoxide init zsh)
fi

if (( $+commands[nvim] )); then
    alias vim=nvim
fi

# List directory contents
alias ls='ls -G'
alias ll='ls -lhF --color=auto'
alias la='ls -lahF --color=auto'

# Command abbreviations
alias f=finder
alias ql=quick-look
alias manp=man-preview
alias lg=lazygit

# Clear the clipboard
function pbclear() {
    printf '' | pbcopy
}

function preview() {
    if (( $+commands[bat] )); then
        fzf --preview 'bat --style=full --color=always {}'
    else
        fzf --preview 'cat {}'
    fi
}

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

# Remove broken symlinks recursively in a directory, default .
function symprune() {
    find -L "${@:-.}" -type l -print -exec rm -- {} +
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

# Remove duplicate entries from paths
typeset -U path manpath infopath
