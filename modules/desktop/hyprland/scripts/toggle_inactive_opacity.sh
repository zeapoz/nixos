#!/usr/bin/env bash

DEFAULT_INACTIVE_OPACITY=0.8

CURRENT_INACTIVE_OPACITY=$(hyprctl -j getoption decoration:inactive_opacity | jq -r '.float')

if [ "$CURRENT_INACTIVE_OPACITY" == "1.000000" ]; then
    hyprctl --batch "keyword decoration:inactive_opacity $DEFAULT_INACTIVE_OPACITY"
    notify-send -e -u low -t 1000 -a Hyprland \
        -i preferences-desktop-visual-effects \
        "Opacity Adjusted" "Inactive window opacity set to $DEFAULT_INACTIVE_OPACITY"
else
    hyprctl --batch "keyword decoration:inactive_opacity 1"
    notify-send -e -u low -t 1000 -a Hyprland \
        -i preferences-desktop-visual-effects \
        "Opacity Reset" "Inactive window opacity restored to 1"
fi
