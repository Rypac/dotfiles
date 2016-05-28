#!/usr/bin/env bash
#
# Remove those inconsiderate .DS_Store files

function purge_ds_store() {
    dir="$1"
    [ ! -w "$dir" ] && prefix='sudo' || prefix=''
    $prefix find "$dir" -name '.DS_Store' -exec rm {} \;
}

function usage() {
    echo "usage: $(basename "$0") [all|home|here]"
}

case "$1" in
    all)
        purge_ds_store '/'
        ;;
    home)
        purge_ds_store "$HOME"
        ;;
    here)
        purge_ds_store '.'
        ;;
    -h|--help)
        usage
        ;;
    *)
        usage && exit 1
        ;;
esac
