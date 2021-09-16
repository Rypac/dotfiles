set -gx LC_COLLATE 'C'
set -gx EDITOR 'vim'
set -gx VISUAL 'subl -w'
set -gx PAGER 'less'
set -gx SELECTED_EDITOR $EDITOR
set -gx LESS '-F -g -i -M -R -S -w -X -z-4'
set -gx LESSHISTFILE "$XDG_CACHE_HOME/lesshistory"
set -gx TERMINFO "$XDG_DATA_HOME/terminfo"
set -gx XINITRC "$XDG_CONFIG_HOME/x11/xinitrc"
set -gx HUSHLOGIN_FILE ''
set -gx HOMEBREW_NO_ANALYTICS 1
set -gx DOTNET_CLI_TELEMETRY_OPTOUT 1
