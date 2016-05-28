#!/usr/bin/env bash
#
# Globally modify floating behaviour of all i3 windows

all_windows="for_window \[class=\"^.*\"\]"
enable_floating="${all_windows} floating enable"
toggle_floating="${all_windows} floating toggle"

function update_config() {
    from="$1"
    to="$2"
    sed -i -- "s/^[# ]*$from/$to/g" "$HOME/.config/i3/config"
}

function apply_config() {
    update_config "$1" "$2"
    i3-msg restart > /dev/null 2>&1
}

function usage() {
    echo "usage: $(basename "$0") [on|off]"
}

case "$1" in
    on)
        apply_config "# $enable_floating" "$enable_floating"
        ;;
    off)
        apply_config "$enable_floating" "# $enable_floating"
        ;;
    toggle)
        apply_config "$toggle_floating" "$toggle_floating"
        sleep 1s && update_config "$toggle_floating" "# $toggle_floating"
        ;;
    -h|--help)
        usage
        ;;
    *)
        usage && exit 1
        ;;
esac
