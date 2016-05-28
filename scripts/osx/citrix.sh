#!/usr/bin/env bash

function up() {
    launchctl load /Library/LaunchAgents/com.citrix.AuthManager_Mac.plist
    launchctl load /Library/LaunchAgents/com.citrix.ReceiverHelper.plist
    launchctl load /Library/LaunchAgents/com.citrix.ServiceRecords.plist
}

function down() {
    launchctl remove com.citrix.AuthManager_Mac
    launchctl remove com.citrix.ReceiverHelper
    launchctl remove com.citrix.ServiceRecords
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
