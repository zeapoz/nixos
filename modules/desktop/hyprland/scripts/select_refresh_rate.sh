#!/usr/bin/env bash

RUNNER="anyrun --plugins libstdin.so"

OPTIONS=(
  "eDP-1,2560x1600@180.00,auto,1.25"
  "eDP-1,2560x1600@120.00,auto,1.25"
  "eDP-1,2560x1600@60.00,auto,1.25"
)

IFS=$'\n' joined="${OPTIONS[*]}"
CHOICE=$(echo "$joined" | eval "$RUNNER")

notify-send -e -u "low" -t 2000 \
  -i weather-clear-symbolic \
  "Montior Configuration Changed" "$CHOICE"
sleep 2

hyprctl keyword monitor "$CHOICE"
