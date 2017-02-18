#!/usr/bin/env bash

lock() {
    if [ -x "$HOME/scripts/i3/lock.sh" ]; then
        "$HOME/scripts/i3/lock.sh"
    else
        i3lock
    fi
}

usage() {
    echo "Usage: $(basename "$0") {lock|logout|sleep|hibernate|reboot|shutdown}"
}

case "$1" in
    lock)
        lock
        ;;
    logout)
        i3-msg exit
        ;;
    sleep)
        lock && systemctl suspend
        ;;
    hibernate)
        lock && systemctl hibernate
        ;;
    reboot)
        systemctl reboot
        ;;
    shutdown)
        systemctl poweroff
        ;;
    -h|--help)
        usage
        ;;
    *)
        usage && exit 1
        ;;
esac
