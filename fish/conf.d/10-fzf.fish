# fzf: general-purpose command-line fuzzy finder
# https://github.com/junegunn/fzf
if status is-interactive; and command -q fzf
    set -gx FZF_TMUX 1

    # ripgrep: line-oriented search tool
    # https://github.com/BurntSushi/ripgrep
    if command -q rg
        set -gx FZF_DEFAULT_COMMAND 'rg --files --hidden --follow'
    end
end
