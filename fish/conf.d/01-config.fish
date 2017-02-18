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
fish_vi_key_bindings

# fzf
if not test -d "$XDG_DATA_HOME/fzf"
    git clone --depth 1 https://github.com/junegunn/fzf.git "$XDG_DATA_HOME/fzf"
    eval "$XDG_DATA_HOME/fzf/install --bin"
end

prepend_to_path "$XDG_DATA_HOME/fzf/bin"
setenv FZF_LEGACY_KEYBINDINGS 0
setenv FZF_TMUX 1

# base16 colour scheme
if not test -d "$XDG_DATA_HOME/base16-shell"
    git clone --depth 1 https://github.com/chriskempson/base16-shell.git "$XDG_DATA_HOME/base16-shell"
end

eval sh "$XDG_DATA_HOME/base16-shell/scripts/base16-oceanicnext.sh"

set -l os (uname)

if [ "$os" = "Linux" ]
    # Rust
    setenv RUST_SRC_PATH "$RUSTUP_HOME/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src"

    # Android SDK/NDK
    setenv JAVA_HOME '/opt/java/jdk'

else if [ "$os" = "Darwin" ]
    # Rust
    setenv RUST_SRC_PATH "$RUSTUP_HOME/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src"

    # Android SDK/NDK
    setenv JAVA_HOME '/Library/Java/JavaVirtualMachines/jdk1.8.0_92.jdk/Contents/Home'
end

if test -z "$GPG_TTY"
    setenv GPG_TTY (tty)
end

append_to_path "$JAVA_HOME/bin"
