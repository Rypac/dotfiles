#!/usr/bin/env bash
#
# Compress files based on the given extension

function usage() {
    echo "usage: $(basename "$0") [compression_type] [input] [output]"
}

if [ "$#" -ne 3 ]; then
    usage && exit 1
fi

compression_type="$1"
target="$2"
output="$3"

case "$compression_type" in
    *.tar.bz2)
        tar cvjf "$target" "$output"
        ;;
    *.tar.gz)
        tar cvzf "$target" "$output"
        ;;
    *.bz2)
        bunzip2 "$target" "$output"
        ;;
    *.rar)
        unrar x "$target" "$output"
        ;;
    *.gz)
        gunzip "$target" "$output"
        ;;
    *.tar)
        tar cvf "$target" "$output"
        ;;
    *.tbz2)
        tar cvjf "$target" "$output"
        ;;
    *.tgz)
        tar cvzf "$target" "$output"
        ;;
    *.zip)
        unzip "$target" "$output"
        ;;
    *.7z)
        7z c "$target" "$output"
        ;;
    -h|--help)
        usage
        ;;
    *)
        if [ ! -f "$target" ]; then
            echo "$target is not a valid file!"
        else
            echo "I don't know how to compress using $compression_type"
        fi
        exit 1
        ;;
esac
