if not status --is-interactive
    exit 0
end

set -l config_home "$XDG_CONFIG_HOME"
set -l data_home "$XDG_DATA_HOME"

# install fisher
if not type fisher >/dev/null 2>&1
    curl -Lo "$config_home/fish/functions/fisher.fish" --create-dirs git.io/fisher
    cat "$config_home/fish/fishfile" | fisher install
end

# vim bindings
fish_vi_key_bindings

# aliases
source "$config_home/fish/aliases.fish"

# fzf
if test -d "$data_home/fzf"
    set -gx PATH "$data_home/fzf/bin" $PATH
    set -gx FZF_LEGACY_KEYBINDINGS 0
end

# z
set -gx Z_CMD "j"
set -gx Z_DATA "$data_home/z"

# base16 colour scheme
if test ! -d "$data_home/base16-shell"
    git clone https://github.com/chriskempson/base16-shell.git "$data_home/base16-shell"
end

eval sh "$data_home/base16-shell/scripts/base16-oceanicnext.sh"

if [ (uname) = "Darwin" ]
    bass source "$HOME/.profile"
    set -gx GPG_TTY (tty)
end
