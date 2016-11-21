#!/bin/sh

options="Lock|Sleep|Logout|Reboot|Shutdown|Cancel"

selection=$(echo $options | rofi -dmenu -sep '|' -p 'Select option: ')
exit_option=$(echo "$selection" | tr '[:upper:]' '[:lower:]')

if [ ! $selection = "Cancel" ]; then
    i3-exit $exit_option
fi

exit 0
