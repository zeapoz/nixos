#!/usr/bin/env sh

# Kill applications.
killall -q .waybar-wrapped
killall -q swaybg

# Start background applications.
waybar &
swaybg -i $(find ~/Pictures/Wallpapers -type f | shuf -n 1) -m fill &
