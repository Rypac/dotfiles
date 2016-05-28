#!/usr/bin/env bash
#
# Extract files based on their extension

function usage() {
    echo "usage: $(basename "$0") [file]"
}

if [ "$#" -ne 1 ]; then
    usage && exit 1
fi

case "$1" in
    *.tar.bz2)
        tar xvjf "$1" && cd $(echo "$1" | sed 's/.tar.bz2//')
        ;;
    *.tar.gz)
        tar xvzf "$1" && cd $(echo "$1" | sed 's/.tar.gz//')
        ;;
    *.tar.xz)
        tar xvzf "$1" && cd $(echo "$1" | sed 's/.tar.xz//')
        ;;
    *.bz2)
        bunzip2 "$1" && cd $(echo "$1" | sed 's/.bz2//')
        ;;
    *.rar)
        unrar x "$1" && cd $(echo "$1" | sed 's/.rar//')
        ;;
    *.gz)
        gunzip "$1" && cd $(echo "$1" | sed 's/.gz//')
        ;;
    *.tar)
        tar xvf "$1" && cd $(echo "$1" | sed 's/.tar//')
        ;;
    *.tbz2)
        tar xvjf "$1" && cd $(echo "$1" | sed 's/.tbz2//')
        ;;
    *.tgz)
        tar xvzf "$1" && cd $(echo "$1" | sed 's/.tgz//')
        ;;
    *.zip)
        unzip "$1" && cd $(echo "$1" | sed 's/.zip//')
        ;;
    *.7z)
        7z x "$1" && cd $(echo "$1" | sed 's/.7z//')
        ;;
    -h|--help)
        usage
        ;;
    *)
        if [ ! -f "$1" ]; then
            echo "$1 is not a valid file!"
        else
            echo "I don't know how to extract $1..."
        fi
        exit 1
        ;;
esac
