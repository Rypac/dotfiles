if status is-interactive; and command -q fzf
    set -gx FZF_TMUX 1

    if command -q rg
        set -gx FZF_DEFAULT_COMMAND 'rg --files --hidden --follow'
    end
end
