#!/bin/bash

options="  Shutdown\n  Restart\n  Suspend\n  Logout"

chosen=$(echo -e "$options" | rofi -dmenu -i -p "Power Menu:" -config ~/.config/rofi/config.rasi)

case "$chosen" in
    "  Shutdown") poweroff ;;
    "  Restart") reboot ;;
    "  Suspend") systemctl suspend ;;
    "  Logout") hyprctl dispatch exit ;;
esac
