#!/usr/bin/env sh

# Kill applications.
killall -q waybar
killall -q swaybg

# Start background applications.
waybar &
swaybg -i $(find ~/Pictures/Wallpapers -type f | shuf -n 1) -m fill &

# Kill services.
killall -q swayidle

# Start background services.
emacs --daemon &
swayidle -w \
    timeout 600 'swaylock -f -c 000000' \
    timeout 660 'systemctl suspend' \
    before-sleep 'swaylock -f -c 000000'
