#!/usr/bin/env bash

function up() {
    launchctl load /Library/LaunchDaemons/com.microsoft.scep_daemon.plist
}

function down() {
    launchctl remove com.microsoft.scep_daemon
}

function usage() {
    echo "usage: $(basename "$0") [up|down]"
}

case "$1" in
    up)
        up && echo "Running"
        ;;
    down)
        down && echo "Stopped"
        ;;
    -h|--help)
        usage
        ;;
    *)
        usage && exit 1
        ;;
esac
