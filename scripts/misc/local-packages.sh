#!/usr/bin/env bash
#
# Update all packages via their locally cloned git repositories

update="update"
install="install"
uninstall="uninstall"
package_dir="$HOME/packages/cloned"

function perform_action() {
    action="$1"
    cd "$package_dir"

    for package in */; do
        cd "$package_dir/$package"
        if [ $action = $update ]; then
            echo "Updating $package"
            git pull --recurse-submodules
        elif [ $action = $install ]; then
            echo "Installing $package"
            make clean && make && sudo make install
        elif [ $action = $uninstall ]; then
            echo "Uninstalling $package"
            sudo make uninstall && make clean
        fi
    done
}

function usage() {
    echo "usage: $(basename "$0") [$update|$install|$uninstall]"
}

case "$1" in
    $update)
        echo "Updating packages..." && perform_action $update
        ;;
    $install)
        echo "Installing packages..." && perform_action $install
        ;;
    $uninstall)
        echo "Uninstalling packages..." && perform_action $uninstall
        ;;
    -h|--help)
        usage
        ;;
    *)
        usage && exit 1
        ;;
esac
