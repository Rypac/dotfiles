#!/usr/bin/env bash

grep "^export" "$HOME/.profile" | while IFS=' =' read ignoreexport envvar ignorevalue; do
    launchctl setenv "${envvar}" "${!envvar}"
done
