# Setup XDG environment variables
setenv XDG_DATA_HOME "$HOME/.local/share"
setenv XDG_CONFIG_HOME "$HOME/.config"
setenv XDG_CACHE_HOME "$HOME/.cache"
setenv DOTFILES_HOME "$HOME/.dotfiles"

# Set config/data directories for XDG unfriendly programs
setenv ATOM_HOME "$XDG_DATA_HOME/atom"
setenv AWS_CONFIG_FILE "$XDG_CONFIG_HOME/aws/config"
setenv AWS_SHARED_CREDENTIALS_FILE "$XDG_CONFIG_HOME/aws/credentials"
setenv ELINKS_CONFDIR "$XDG_CONFIG_HOME/elinks"
setenv ENHANCD_DIR "$XDG_DATA_HOME/enhancd"
setenv GIMP2_DIRECTORY "$XDG_CONFIG_HOME/gimp"
setenv GTK2_RC_FILES "$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
setenv HTTPIE_CONFIG_DIR "$XDG_CONFIG_HOME/httpie"
setenv MPLAYER_HOME "$XDG_CONFIG_HOME/mplayer"
setenv PASSWORD_STORE_DIR "$XDG_DATA_HOME/pass"
setenv QT_QPA_PLATFORMTHEME "gtk2"
setenv QT_STYLE_OVERRIDE GTK+
setenv SCREENRC "$XDG_CONFIG_HOME/screen/screenrc"
setenv TERMINFO "$XDG_DATA_HOME/terminfo"
setenv TIGRC_USER "$XDG_CONFIG_HOME/tig/tigrc"
setenv WEECHAT_HOME "$XDG_CONFIG_HOME/weechat"
setenv WINEPREFIX "$XDG_DATA_HOME/wine"
setenv XINITRC "$XDG_CONFIG_HOME/x11/xinitrc"
setenv ZPLUG_HOME "$XDG_DATA_HOME/zplug"
setenv Z_DATA "$XDG_DATA_HOME/z"
setenv _Z_DATA "$Z_DATA"

# Set cache/runtime directories for XDG unfriendly programs
setenv CUDA_CACHE_PATH "$XDG_CACHE_HOME/nv"
setenv LESSHISTFILE "$XDG_CACHE_HOME/lesshistory"
setenv ICEAUTHORITY "$XDG_RUNTIME_DIR/ICEauthority"
setenv RXVT_SOCKET "$XDG_RUNTIME_DIR/urxvtd"
setenv TMUX_TMPDIR "$XDG_RUNTIME_DIR"
setenv __GL_SHADER_DISK_CACHE_PATH "$XDG_CACHE_HOME/nv"

# Programming environments
setenv CARGO_HOME "$XDG_DATA_HOME/cargo"
setenv RUSTUP_HOME "$XDG_DATA_HOME/rustup"
setenv STACK_ROOT "$XDG_DATA_HOME/stack"
setenv NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME/npm/config"
setenv BUNDLE_PATH "$XDG_CACHE_HOME/bundle"
setenv GEM_SPEC_CACHE "$XDG_CACHE_HOME/ruby/gem/spec"
setenv RBENV_ROOT "$XDG_DATA_HOME/rbenv"
setenv MIX_HOME "$XDG_DATA_HOME/mix"
setenv GRADLE_USER_HOME "$XDG_CACHE_HOME/gradle"
setenv ANDROID_SDK_HOME "$XDG_DATA_HOME/android"
setenv ANDROID_HOME "$ANDROID_SDK_HOME/sdk"
setenv ANDROID_SDK_ROOT "$ANDROID_HOME"
setenv ANDROID_NDK "$ANDROID_HOME/ndk-bundle"
setenv NDK_ROOT "$ANDROID_NDK"

# Defaults
setenv LC_COLLATE 'C'
setenv EDITOR 'nvim'
setenv VISUAL 'code'
setenv PAGER 'less'
setenv SELECTED_EDITOR 'nvim'
setenv LESS '-F -g -i -M -R -S -w -X -z-4'
setenv SHELL '/usr/bin/fish'
setenv HUSHLOGIN_FILE ''

# Setup PATH
if status --is-interactive
    prepend_to_path "$HOME/bin" "$HOME/.local/bin" "$CARGO_HOME/bin" "$ANDROID_HOME/tools" "$ANDROID_HOME/platform-tools" "/usr/local/bin"
end
