#!/usr/bin/env bash

up() {
    launchctl load /Library/LaunchAgents/com.paloaltonetworks.gp.pangpa.plist
    launchctl load /Library/LaunchAgents/com.paloaltonetworks.gp.pangps.plist
}

down() {
    launchctl remove com.paloaltonetworks.gp.pangpa
    launchctl remove com.paloaltonetworks.gp.pangps
}

usage() {
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
