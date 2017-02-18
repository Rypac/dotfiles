#!/usr/bin/env bash
#
# Run a chrome app

usage() {
    echo "usage: $(basename "$0") NAME URL"
}

rename_window() {
    app_pid="$1"
    app_window=''
    until [ -n "$app_window" ]; do
        sleep 0.1s
        app_window=$(wmctrl -lp | grep $app_pid | cut -d' ' -f1)
    done

    wmctrl -i -r "$app_window" -N "ChromeApp: $name"
}

if [ "$#" -ne 2 ]; then
    usage && exit 1
fi

name="$1"
app="$2"

google-chrome --app="$app" > /dev/null 2>&1 &
# rename_window $!
