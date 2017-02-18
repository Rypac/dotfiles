#!/usr/bin/env bash

if type sensors > /dev/null 2>&1; then
    sensors
fi
if type nvidia-smi > /dev/null 2>&1; then
    nvidia-smi -i 0 -q -d TEMPERATURE,POWER,CLOCK
fi
