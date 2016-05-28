# Setup fzf
if [[ ! "$PATH" == *$XDG_CONFIG_HOME/fzf/bin* ]]; then
    export PATH="$PATH:$XDG_CONFIG_HOME/fzf/bin"
fi

if [[ ! "$MANPATH" == *$XDG_CONFIG_HOME/fzf/man* && -d "$XDG_CONFIG_HOME/fzf/man" ]]; then
    export MANPATH="$MANPATH:$XDG_CONFIG_HOME/fzf/man"
fi

if [[ $- == *i* ]]; then
    source "$XDG_CONFIG_HOME/fzf/shell/completion.zsh" 2> /dev/null
    export FZF_COMPLETION_TRIGGER='~~'
fi
