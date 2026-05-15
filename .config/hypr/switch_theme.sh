#!/bin/bash

DIR="$HOME/wallpapers"

CHOICE=$(for img in "$DIR"/*; do
    echo -en "$(basename "$img")\x00icon\x1f$img\n"
done | rofi -dmenu -p "Wallpaper" \
    -show-icons \
    -theme-str '
    configuration { show-icons: true; }
    element { orientation: vertical; children: [ "element-icon", "element-text" ]; }
    element-icon { size: 150px; enabled: true; }
    element-text { horizontal-align: 0.5; }
    listview { columns: 3; lines: 2; }
    ' -config ~/.config/rofi/config.rasi)

if [ -n "$CHOICE" ]; then
    WALL="$DIR/$CHOICE"
    wal -i "$WALL"
    pkill swaybg
    swaybg -i "$WALL" -m fill &
    killall waybar && waybar &
fi
