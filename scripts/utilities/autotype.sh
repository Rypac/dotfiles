#!/usr/bin/env bash
#
# Simulate virtual on-screen typing

autotype() {
    if type pv > /dev/null 2>&1; then
        echo "$1" | pv -qL 10
    else
        echo "$1"
    fi
}

if $(read -t 0); then
    read input
    autotype "$input"
elif [ $# -ne 0 ]; then
    autotype "$1"
else
    exit 1
fi
