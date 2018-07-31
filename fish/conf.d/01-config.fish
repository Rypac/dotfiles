if not status --is-interactive
    exit
end

# colours
set -gx fish_color_autosuggestion brblack
set -gx fish_color_command purple
set -gx fish_color_comment yellow
set -gx fish_color_end purple
set -gx fish_color_error red
set -gx fish_color_param blue
set -gx fish_color_quote green
set -gx fish_color_redirection cyan

# autojump
complete -x -c j -a '(autojump --complete (commandline -t))'

# gpg
if command -sq gpgconf
    set -gx GPG_TTY (tty)
    set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
    gpgconf --launch gpg-agent
end

switch (uname)
    case Linux
        set -gx RUST_SRC_PATH "$RUSTUP_HOME/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src"
        set -gx JAVA_HOME "/opt/java/jdk"
        append_to_path "$JAVA_HOME/bin"
    case Darwin
        set -gx RUST_SRC_PATH "$RUSTUP_HOME/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src"
        append_to_path "$HOME/Library/Python/3.7/bin"
end
