set -gx GHCUP_USE_XDG_DIRS 1

if command -q cabal
    set -gx CABAL_DIR "$XDG_DATA_HOME/cabal"
    fish_add_path --append "$CABAL_DIR/bin"
end

if command -q stack
    set -gx STACK_ROOT "$XDG_DATA_HOME/stack"
end
