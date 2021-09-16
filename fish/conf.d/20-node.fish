if type -q node
    set -gx NODE_REPL_HISTORY "$XDG_CACHE_HOME/node-repl-history"
    set -gx NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME/npm/config"
end
