# Setup XDG environment variables
set -q "$XDG_DATA_HOME"; or set -gx XDG_DATA_HOME "$HOME/.local/share"
set -q "$XDG_CONFIG_HOME"; or set -gx XDG_CONFIG_HOME "$HOME/.config"
set -q "$XDG_CACHE_HOME"; or set -gx XDG_CACHE_HOME "$HOME/.cache"
set -q "$DOTFILES_HOME"; or set -gx DOTFILES_HOME "$HOME/.dotfiles"

# Set config/data/cache directories for XDG unfriendly programs
set -gx AWS_CONFIG_FILE "$XDG_CONFIG_HOME/aws/config"
set -gx AWS_SHARED_CREDENTIALS_FILE "$XDG_CONFIG_HOME/aws/credentials"
set -gx ELINKS_CONFDIR "$XDG_CONFIG_HOME/elinks"
set -gx ENHANCD_DIR "$XDG_DATA_HOME/enhancd"
set -gx HTTPIE_CONFIG_DIR "$XDG_CONFIG_HOME/httpie"
set -gx LESSHISTFILE "$XDG_CACHE_HOME/lesshistory"
set -gx MPLAYER_HOME "$XDG_CONFIG_HOME/mplayer"
set -gx PASSWORD_STORE_DIR "$XDG_DATA_HOME/pass"
set -gx SPACEMACSDIR "$XDG_CONFIG_HOME/spacemacs"
set -gx TERMINFO "$XDG_DATA_HOME/terminfo"
set -gx XINITRC "$XDG_CONFIG_HOME/x11/xinitrc"

# Programming environments
set -gx CARGO_HOME "$XDG_DATA_HOME/cargo"
set -gx RUSTUP_HOME "$XDG_DATA_HOME/rustup"
set -gx STACK_ROOT "$XDG_DATA_HOME/stack"
set -gx NODE_REPL_HISTORY "$XDG_CACHE_HOME/node-repl-history"
set -gx NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME/npm/config"
set -gx CP_HOME_DIR "$XDG_CACHE_HOME/cocoapods"
set -gx CP_REPOS_DIR "$CP_HOME_DIR/repos"
set -gx BUNDLE_PATH "$XDG_CACHE_HOME/bundle"
set -gx GEM_SPEC_CACHE "$XDG_CACHE_HOME/ruby/gem/spec"
set -gx RBENV_ROOT "$XDG_DATA_HOME/rbenv"

# Defaults
set -gx LC_COLLATE 'C'
set -gx EDITOR 'vim'
set -gx VISUAL 'subl'
set -gx PAGER 'less'
set -gx SELECTED_EDITOR 'vim'
set -gx LESS '-F -g -i -M -R -S -w -X -z-4'
set -gx HUSHLOGIN_FILE ''
set -gx HOMEBREW_NO_ANALYTICS 1
set -gx DOTNET_CLI_TELEMETRY_OPTOUT 1
set -gx AUTOJUMP_SOURCED 1
set -gx FZF_TMUX 1
set -gx FZF_DEFAULT_COMMAND 'rg --files --no-ignore-vcs --hidden'
set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND

# Setup PATH
set -gx PATH "$HOME/.local/bin" "/usr/local/sbin" "/usr/local/bin" $PATH
