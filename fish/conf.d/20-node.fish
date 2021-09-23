if command -q node
    set -gx NODE_REPL_HISTORY "$XDG_STATE_HOME/node_repl_history"
    set -gx NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME/npm/config"
end
