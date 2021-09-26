set -gx GHCUP_USE_XDG_DIRS 1

if command -q stack
    set -gx STACK_ROOT "$XDG_DATA_HOME/stack"
end
