# source profile
bass source ~/.profile

set -l config_home "$XDG_CONFIG_HOME"
set -l data_home "$XDG_DATA_HOME"

if test -z "$config_home"
    set config_home ~/.config
end

if test -z "$data_home"
    set cache_home ~/.local/share
end

# install fisher
if not type fisher >/dev/null 2>&1
    curl -Lo "$config_home/fish/functions/fisher.fish" --create-dirs git.io/fisher
    fisher up
end

# vim bindings
fish_vi_key_bindings

# z
set -U Z_CMD "j"
set -U Z_DATA "$data_home/z"

# fzf
if test -d "$data_home/fzf"
    set -gx PATH "$data_home/fzf/bin" $PATH
end

# base16 colour scheme
if status --is-interactive
    set -l base16_home "$data_home/base16-shell"

    if test ! -d "$base16_home"
        git clone https://github.com/chriskempson/base16-shell.git "$base16_home"
    end

    eval sh "$base16_home/scripts/base16-oceanicnext.sh"
end

# alises
alias vi nvim
alias vim nvim
