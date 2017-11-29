if not status --is-interactive
    exit
end

# Ensure directories exist
if not test -d "$XDG_CONFIG_HOME"
    mkdir -p "$XDG_CONFIG_HOME"
end
if not test -d "$XDG_DATA_HOME"
    mkdir -p "$XDG_DATA_HOME"
end

# vim bindings
fish_hybrid_key_bindings

# colours
set -gx fish_color_autosuggestion "brblack"
set -gx fish_color_command "purple"
set -gx fish_color_comment "yellow"
set -gx fish_color_end "purple"
set -gx fish_color_error "red"
set -gx fish_color_param "blue"
set -gx fish_color_quote "green"
set -gx fish_color_redirection "cyan"

# fzf
if not test -d "$XDG_DATA_HOME/fzf"
    git clone --depth 1 https://github.com/junegunn/fzf.git "$XDG_DATA_HOME/fzf"
    eval "$XDG_DATA_HOME/fzf/install --bin"
end

prepend_to_path "$XDG_DATA_HOME/fzf/bin"
set -gx FZF_LEGACY_KEYBINDINGS 0
set -gx FZF_TMUX 1

# base16 colour scheme
if not test -d "$XDG_DATA_HOME/base16-shell"
    git clone --depth 1 https://github.com/chriskempson/base16-shell.git "$XDG_DATA_HOME/base16-shell"
end

eval sh "$XDG_DATA_HOME/base16-shell/scripts/base16-oceanicnext.sh"

# Install fisherman and plugins
set -l fisher_function "$XDG_CONFIG_HOME/fish/functions/fisher.fish"
if not test -f "$fisher_function"
    curl -Lo "$fisher_function" --create-dirs git.io/fisher
    source "$fisher_function"
    fisher
end

if test -z "$GPG_TTY"
    set -gx GPG_TTY (tty)
end

switch (uname)
    case Linux
        set -gx RUST_SRC_PATH "$RUSTUP_HOME/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src"
        set -gx JAVA_HOME "/opt/java/jdk"
        append_to_path "$JAVA_HOME/bin"
    case Darwin
        if not count (pgrep -x -u "$USER" gpg-agent) > /dev/null
            gpg-agent --homedir "$HOME/.gnupg" --enable-ssh-support --daemon > /dev/null 2>&1
            gpg-connect-agent updatestartuptty /bye > /dev/null
        end

        set -gx SSH_AUTH_SOCK "$HOME/.gnupg/S.gpg-agent.ssh"
        set -gx RUST_SRC_PATH "$RUSTUP_HOME/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src"
        append_to_path "$HOME/Library/Python/3.6/bin"
end

# Aliases

function make_alias --description 'Faster implementation of alias'
    set -l name $argv[1]
    set -l body $argv[2..-1]
    echo "function $name; $body \$argv; end" | source
end

make_alias vi nvim
make_alias vim nvim
make_alias pip pip3
make_alias vscode code
