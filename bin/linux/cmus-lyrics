#!/usr/bin/env bash

fetch_tag() {
    cmus-remote -Q | grep "tag $1 " | cut -d' ' -f3-
}

title=$(fetch_tag 'title')
album=$(fetch_tag 'album')
artist=$(fetch_tag 'artist')

encoded_artist=$(perl -MURI::Escape -e 'print uri_escape($ARGV[0]);' "$artist")
encoded_title=$(perl -MURI::Escape -e 'print uri_escape($ARGV[0]);' "$title")

lyrics=$(curl -s "https://makeitpersonal.co/lyrics?artist=${encoded_artist}&title=${encoded_title}")

cat << EOF
$title
$album
$artist

---------------
$lyrics
EOF
