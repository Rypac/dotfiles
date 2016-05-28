#!/bin/sh

workspaces=$("$HOME/scripts/i3/all-workspaces.sh")
workspace=$(echo "$workspaces"  | rofi -dmenu -p "Select workspace:")

if [ -n "$workspace" ]; then
    i3-msg workspace "$workspace"
fi
