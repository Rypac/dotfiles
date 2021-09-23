if status is-interactive; and type -q fzf
    set -gx FZF_TMUX 1

    if type -q rg
        set -gx FZF_DEFAULT_COMMAND 'rg --files --hidden --follow'
        set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
    end
end
