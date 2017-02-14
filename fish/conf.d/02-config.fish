# Ensure directories exist
if test ! -d "$XDG_CONFIG_HOME"
    mkdir -p "$XDG_CONFIG_HOME"
end

if test ! -d "$XDG_DATA_HOME"
    mkdir -p "$XDG_DATA_HOME"
end

# vim bindings
fish_vi_key_bindings

# fzf
if test ! -d "$XDG_DATA_HOME/fzf"
    git clone https://github.com/junegunn/fzf.git "$XDG_DATA_HOME/fzf"
    eval "$XDG_DATA_HOME/fzf/install --bin"
end

set -gx PATH "$XDG_DATA_HOME/fzf/bin" $PATH
set -gx FZF_LEGACY_KEYBINDINGS 0
set -gx FZF_TMUX 1

# z
set -gx Z_CMD "j"
set -gx Z_DATA "$XDG_DATA_HOME/z"

# base16 colour scheme
if test ! -d "$XDG_DATA_HOME/base16-shell"
    git clone https://github.com/chriskempson/base16-shell.git "$XDG_DATA_HOME/base16-shell"
end

eval sh "$XDG_DATA_HOME/base16-shell/scripts/base16-oceanicnext.sh"

if [ (uname) = "Linux" ]
    # Rust
    set -gx RUST_SRC_PATH "$RUSTUP_HOME/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src"

    # Android SDK/NDK
    set -gx JAVA_HOME '/opt/java/jdk'

else if [ (uname) = "Darwin" ]
    # GPG
    set -gx GPG_TTY (tty)

    # Rust
    set -gx RUST_SRC_PATH "$RUSTUP_HOME/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src"

    # Android SDK/NDK
    set -gx ANT_ROOT '/usr/local/Cellar/ant/1.9.7/bin'
    set -gx JAVA_HOME '/Library/Java/JavaVirtualMachines/jdk1.8.0_92.jdk/Contents/Home'
end

if test -z "$JAVA_HOME"
    set -gx PATH $PATH "$JAVA_HOME/bin"
end

# Remove duplicates from $PATH
dedup_env PATH
