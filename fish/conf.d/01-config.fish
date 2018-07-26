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

# colours
set -gx fish_color_autosuggestion "brblack"
set -gx fish_color_command "purple"
set -gx fish_color_comment "yellow"
set -gx fish_color_end "purple"
set -gx fish_color_error "red"
set -gx fish_color_param "blue"
set -gx fish_color_quote "green"
set -gx fish_color_redirection "cyan"

# base16 colour scheme
if not test -d "$XDG_DATA_HOME/base16-shell"
    git clone --depth 1 https://github.com/chriskempson/base16-shell.git "$XDG_DATA_HOME/base16-shell"
end

eval sh "$XDG_DATA_HOME/base16-shell/scripts/base16-oceanicnext.sh"

# autojump
complete -x -c j -a '(autojump --complete (commandline -t))'

if test -z "$GPG_TTY"
    set -gx GPG_TTY (tty)
end

switch (uname)
    case Linux
        set -gx RUST_SRC_PATH "$RUSTUP_HOME/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src"
        set -gx JAVA_HOME "/opt/java/jdk"
        append_to_path "$JAVA_HOME/bin"
    case Darwin
        # set -gx SSH_AUTH_SOCK "$HOME/.gnupg/S.gpg-agent.ssh"
        set -gx RUST_SRC_PATH "$RUSTUP_HOME/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src"
        append_to_path "$HOME/Library/Python/3.7/bin"
end
