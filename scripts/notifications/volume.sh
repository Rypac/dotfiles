#!/usr/bin/env bash

mixer="default"
[ -n "$(lsmod | grep pulse)" ] && mixer="pulse"
[ -n "$(lsmod | grep jack)" ] && mixer="jackplug"

scontrol="$(
    amixer -D $mixer scontrols |
    sed -n "s/Simple mixer control '\([A-Za-z ]*\)',0/\1/p" |
    head -n1
)"

function has() {
    type "$1" > /dev/null 2>&1
}

function get_level() {
    perl -ne 'if (/.*\[(\d+)%\] \[(on|off)\]/) { CORE::say $1; exit }'
}

function get_status() {
    perl -ne 'if (/.*\[(\d+)%\] \[(on|off)\]/) { CORE::say $2 eq "off" ? "MUTE" : ""; exit }'
}

function notify() {
    mixer="$(amixer -D "$mixer" get "$scontrol")"
    level=$(echo "$mixer" | get_level)
    status=$(echo "$mixer" | get_status)
    notify-send "volume-control" -h "int:value:$level" "$status"
}

has notify-send && notify
