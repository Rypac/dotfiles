#!/bin/sh

for node_id in $(bspc query -N); do
    bspc node $node_id -c
done

bspc quit
