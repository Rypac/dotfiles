set -l config_home "$XDG_CONFIG_HOME"
set -l data_home "$XDG_DATA_HOME"

# vim bindings
fish_vi_key_bindings

# Install fisher and plugins
if not functions -q fisher
    set -l fisher_home "$config_home/fish/functions/fisher.fish"
    curl -Lo "$fisher_home" --create-dirs git.io/fisher
    source "$fisher_home"
    fisher
end

# fzf
if test ! -d "$data_home/fzf"
    git clone https://github.com/junegunn/fzf.git "$data_home/fzf"
    eval "$data_home/fzf/install --bin"
end

set -gx PATH "$data_home/fzf/bin" $PATH
set -gx FZF_LEGACY_KEYBINDINGS 0
set -gx FZF_TMUX 1

# z
set -gx Z_CMD "j"
set -gx Z_DATA "$data_home/z"

# base16 colour scheme
if test ! -d "$data_home/base16-shell"
    git clone https://github.com/chriskempson/base16-shell.git "$data_home/base16-shell"
end

eval sh "$data_home/base16-shell/scripts/base16-oceanicnext.sh"

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
