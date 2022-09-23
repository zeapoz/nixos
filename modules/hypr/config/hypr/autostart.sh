#!/usr/bin/env sh

# Kill applications.
killall -q .waybar-wrapped -9
killall -q swaybg -9

# Start background applications.
waybar &
swaybg -i $(find ~/Pictures/Wallpapers -type f | shuf -n 1) -m fill &

# Start background services.
emacs --daemon &
