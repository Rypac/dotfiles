#!/bin/sh
#
# Determine the name of the OS

host_name=$(uname | tr '[:upper:]' '[:lower:]')

if [ "$host_name" = "linux" ]; then
    if type lsb_release > /dev/null 2>&1; then
        host_name=$(lsb_release -i | sed 's/^.*:\t//')
    fi
elif [ "$host_name" = "darwin" ]; then
    host_name="Darwin"
fi

export DISTRO="$host_name"

echo $DISTRO
