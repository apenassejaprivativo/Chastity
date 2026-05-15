#!/bin/bash

playerctl --follow metadata --format '{{title}}||{{artist}}||{{mpris:artUrl}}' | while read -r line; do

    IFS="||" read -r title artist album_art <<< "$line"

    notify-send -a "Spotify" -i "$album_art" -h string:x-canonical-private-synchronous:spotify "$title" "$artist"

done
