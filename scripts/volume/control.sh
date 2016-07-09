#!/usr/bin/env bash

mute='toggle'
up='up'
down='down'

mixer="default"
[ -n "$(lsmod | grep pulse)" ] && mixer="pulse"
[ -n "$(lsmod | grep jack)" ] && mixer="jackplug"
mixer="${3:-$mixer}"

scontrol="$(
    amixer -D $mixer scontrols |
    sed -n "s/Simple mixer control '\([A-Za-z ]*\)',0/\1/p" |
    head -n1
)"

function capability() {
    amixer -D $mixer get $scontrol | sed -n "s/  Capabilities:.*cvolume.*/Capture/p"
}

function usage() {
    echo "usage: $(basename "$0") [$up|$down|$mute]"
}

selection="$1"
step="${2:-5%}" # This may be in in % or dB (eg. 5% or 3dB)

case "$selection" in
    $mute)
        amixer -q -D $mixer sset $scontrol $(capability) toggle
        ;;
    $up)
        amixer -q -D $mixer sset $scontrol $(capability) ${step}+ unmute
        ;;
    $down)
        amixer -q -D $mixer sset $scontrol $(capability) ${step}- unmute
        ;;
    -h|--help)
        usage
        ;;
    *)
        usage && exit 1
        ;;
esac
