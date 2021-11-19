# RubyGems: package management framework for Ruby
# https://github.com/rubygems/rubygems
set -gx GEM_HOME "$XDG_DATA_HOME/gem"
set -gx GEM_SPEC_CACHE "$XDG_CACHE_HOME/gem"
fish_add_path --append "$GEM_HOME/bin"

# rbenv: Ruby environment manager
# https://github.com/rbenv/rbenv
if status is-interactive; and command -q rbenv
    set -gx RBENV_ROOT "$XDG_DATA_HOME/rbenv"
    source (rbenv init -|psub)
end
