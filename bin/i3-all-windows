#!/bin/sh

i3-msg -t get_tree | tr ',' '\n' | grep "\"window\"" | cut -d ':' -f 2 | grep -v null
