set -gx BUNDLE_PATH "$XDG_CACHE_HOME/bundle"
set -gx GEM_SPEC_CACHE "$XDG_CACHE_HOME/ruby/gem/spec"

if type -q rbenv
    set -gx RBENV_ROOT "$XDG_DATA_HOME/rbenv"

    if status is-interactive
        source (rbenv init -|psub)
    end
end
