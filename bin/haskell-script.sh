#!/usr/bin/env zsh
#
# Run a Haskell script with the appropriate tool

if [ ! -f "$1" ]; then
    echo "usage: $(basename "$0") FILE"
    exit 1
fi

case "$(head -1 "$1")" in
    '#!/usr/bin/env runghc')
        runghc "$@" ;;
    '#!/usr/bin/env runhaskell')
        runhaskell "$@" ;;
    '#!/usr/bin/env cabal'|'{- cabal:')
        cabal run -v0 "$@" ;;
    '#!/usr/bin/env stack')
        stack --silent "$@" ;;
    '-- stack script'*|'{- stack script'*)
        stack --silent =(cat <(echo '#!/usr/bin/env stack') "$1") "${@:2}" ;;
    *)
        runghc "$@" ;;
esac
