#!/usr/bin/env bash

fhd='DPY-1: nvidia-auto-select @1920x1080 +0+0 {ViewPortIn=1920x1080, ViewPortOut=2560x1440+0+0}'
qhd='DPY-1: 2560x1440_96 @2560x1440 +0+0 {ViewPortIn=2560x1440, ViewPortOut=2560x1440+0+0}'

function switch_to_resolution() {
    nvidia-settings --assign "CurrentMetaMode=$1"
    xcalib "$HOME/.config/display/qnix-120-6500k.profile"
}

function usage() {
    echo "Usage: $(basename "$0") {fhd|qhd}"
}

case "$1" in
    fhd)
        switch_to_resolution "$fhd"
        ;;
    qhd)
        switch_to_resolution "$qhd"
        ;;
    -h|--help)
        usage
        ;;
    *)
        usage && exit 1
        ;;
esac
