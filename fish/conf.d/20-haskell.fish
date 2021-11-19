# GHCup: installer for Haskell and development tools
# https://www.haskell.org/ghcup/
set -gx GHCUP_USE_XDG_DIRS 1

# Cabal: system for building and packaging Haskell libraries and programs
# https://www.haskell.org/cabal/
set -gx CABAL_DIR "$XDG_DATA_HOME/cabal"
fish_add_path --append "$CABAL_DIR/bin"

# Stack: cross-platform program for developing Haskell projects
# https://docs.haskellstack.org
if command -q stack
    set -gx STACK_ROOT "$XDG_DATA_HOME/stack"
end
