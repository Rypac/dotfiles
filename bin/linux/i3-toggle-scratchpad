#!/usr/bin/env bash

usage() {
    echo "Usage: $(basename "$0") NAME [COMMAND]"
}

scratchpad_exists() {
    i3-msg -t get_tree | grep -Po "\"instance\":\"$1\""
}

create_scratchpad() {
    [[ ! -z "$2" ]] && args="-e $2" || args=""
    i3-msg -q "exec --no-startup-id urxvt -name $1 $args" && sleep 0.2
    i3-msg -q [instance="$1"] border none
    i3-msg -q [instance="$1"] floating enable
    i3-msg -q [instance="$1"] move scratchpad
}

show_scratchpad() {
    i3-msg -q [instance="$1"] scratchpad show
}

if [[ $# -lt 1 ]]; then
    usage && exit 1
fi

name="$1"
program="$2"

if ! scratchpad_exists "$name" > /dev/null 2>&1; then
    create_scratchpad "$name" "$program"
fi

show_scratchpad "$name"
