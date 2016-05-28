#!/bin/sh

[ $commands[sensors] ] && sensors
[ $commands[nvidia-smi] ] && nvidia-smi -i 0 -q -d TEMPERATURE,POWER,CLOCK

exit 0
