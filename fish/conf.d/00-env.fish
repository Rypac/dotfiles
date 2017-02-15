# Setup XDG environment variables
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_CACHE_HOME "$HOME/.cache"
set -gx DOTFILES_HOME "$HOME/.dotfiles"

# Set config/data directories for XDG unfriendly programs
set -gx ATOM_HOME "$XDG_DATA_HOME/atom"
set -gx AWS_CONFIG_FILE "$XDG_CONFIG_HOME/aws/config"
set -gx AWS_SHARED_CREDENTIALS_FILE "$XDG_CONFIG_HOME/aws/credentials"
set -gx ELINKS_CONFDIR "$XDG_CONFIG_HOME/elinks"
set -gx ENHANCD_DIR "$XDG_DATA_HOME/enhancd"
set -gx GIMP2_DIRECTORY "$XDG_CONFIG_HOME/gimp"
set -gx GTK2_RC_FILES "$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
set -gx HTTPIE_CONFIG_DIR "$XDG_CONFIG_HOME/httpie"
set -gx MPLAYER_HOME "$XDG_CONFIG_HOME/mplayer"
set -gx PASSWORD_STORE_DIR "$XDG_DATA_HOME/pass"
set -gx QT_QPA_PLATFORMTHEME "gtk2"
set -gx QT_STYLE_OVERRIDE GTK+
set -gx SCREENRC "$XDG_CONFIG_HOME/screen/screenrc"
set -gx TERMINFO "$XDG_DATA_HOME/terminfo"
set -gx TIGRC_USER "$XDG_CONFIG_HOME/tig/tigrc"
set -gx WEECHAT_HOME "$XDG_CONFIG_HOME/weechat"
set -gx WINEPREFIX "$XDG_DATA_HOME/wine"
set -gx XINITRC "$XDG_CONFIG_HOME/x11/xinitrc"
set -gx Z_DATA "$XDG_DATA_HOME/z"

# Set cache/runtime directories for XDG unfriendly programs
set -gx CUDA_CACHE_PATH "$XDG_CACHE_HOME/nv"
set -gx LESSHISTFILE "$XDG_CACHE_HOME/lesshistory"
set -gx ICEAUTHORITY "$XDG_RUNTIME_DIR/ICEauthority"
set -gx RXVT_SOCKET "$XDG_RUNTIME_DIR/urxvtd"
set -gx TMUX_TMPDIR "$XDG_RUNTIME_DIR"
set -gx __GL_SHADER_DISK_CACHE_PATH "$XDG_CACHE_HOME/nv"

# Programming environments
set -gx CARGO_HOME "$XDG_DATA_HOME/cargo"
set -gx RUSTUP_HOME "$XDG_DATA_HOME/rustup"
set -gx STACK_ROOT "$XDG_DATA_HOME/stack"
set -gx NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME/npm/config"
set -gx BUNDLE_PATH "$XDG_CACHE_HOME/bundle"
set -gx GEM_SPEC_CACHE "$XDG_CACHE_HOME/ruby/gem/spec"
set -gx RBENV_ROOT "$XDG_DATA_HOME/rbenv"
set -gx MIX_HOME "$XDG_DATA_HOME/mix"
set -gx GRADLE_USER_HOME "$XDG_CACHE_HOME/gradle"
set -gx ANDROID_SDK_HOME "$XDG_DATA_HOME/android"
set -gx ANDROID_HOME "$ANDROID_SDK_HOME/sdk"
set -gx ANDROID_SDK_ROOT "$ANDROID_HOME"
set -gx ANDROID_NDK "$ANDROID_HOME/ndk-bundle"
set -gx NDK_ROOT "$ANDROID_NDK"

# Defaults
set -gx LC_COLLATE 'C'
set -gx EDITOR 'nvim'
set -gx VISUAL 'code'
set -gx PAGER 'less'
set -gx SELECTED_EDITOR 'nvim'
set -gx LESS '-F -g -i -M -R -S -w -X -z-4'
set -gx SHELL '/usr/bin/fish'

# Setup PATH
if status --is-interactive
    prepend_to_path "$HOME/bin" "$HOME/.local/bin" "$CARGO_HOME/bin" "$ANDROID_HOME/tools" "$ANDROID_HOME/platform-tools"
end
