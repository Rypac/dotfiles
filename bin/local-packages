#!/usr/bin/env bash
#
# Update all packages via their locally cloned git repositories

package_dir="${2:-$HOME/packages/cloned}"

needs_update() {
    [ "$(git rev-parse @)" != "$(git rev-parse @{u})" ]
}

update() {
    echo "Updating $1"
    git pull --recurse-submodules
}

build_and_install() {
    echo "Installing $1"
    make clean
    make
    sudo checkinstall --default --install=yes --nodoc --deldoc=yes --deldesc=yes --delspec=yes --backup=no
}

upgrade() {
    echo "Upgrading $1"
    git fetch
    if needs_update; then
        update
        build_and_install
    else
        echo "Already up to date"
    fi
}

uninstall() {
    echo "Uninstalling $1"
    sudo make uninstall
    make clean
}

perform_action() {
    action="$1"
    cd "$package_dir"

    for package in */; do
        (cd "$package" && $action "$package")
    done
}

usage() {
    echo "usage: $(basename "$0") [update|install|uninstall]"
}

case "$1" in
    update)
        echo "Updating packages..." && perform_action update
        ;;
    install)
        echo "Installing packages..." && perform_action build_and_install
        ;;
    upgrade)
        echo "Upgrading packages..." && perform_action upgrade
        ;;
    uninstall)
        echo "Uninstalling packages..." && perform_action uninstall
        ;;
    -h|--help)
        usage
        ;;
    *)
        usage && exit 1
        ;;
esac
