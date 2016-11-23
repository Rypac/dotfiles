#!/bin/sh

source_dir="$1"
target_dir="$2"

for f in "$source_dir"/*; do
    name="$(basename "$f")"
    ln -fs "$f" "$target_dir/${name%.sh}"
done
