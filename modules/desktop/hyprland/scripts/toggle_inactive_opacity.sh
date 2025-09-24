#!/usr/bin/env bash

DEFAULT_INACTIVE_OPACITY="1.000000"
ALTERNATIVE_INACTIVE_OPACITY="0.800000"

CURRENT_INACTIVE_OPACITY=$(hyprctl -j getoption decoration:inactive_opacity | jq -r '.float')

if [ "$CURRENT_INACTIVE_OPACITY" == "$DEFAULT_INACTIVE_OPACITY" ]; then
  hyprctl --batch "keyword decoration:inactive_opacity $ALTERNATIVE_INACTIVE_OPACITY"
  notify-send -e -u low -t 2000 -a Hyprland \
    -i preferences-desktop-visual-effects \
    "Opacity Adjusted" "Inactive window opacity set to $ALTERNATIVE_INACTIVE_OPACITY"
else
  hyprctl --batch "keyword decoration:inactive_opacity $DEFAULT_INACTIVE_OPACITY"
  notify-send -e -u low -t 2000 -a Hyprland \
    -i preferences-desktop-visual-effects \
    "Opacity Reset" "Inactive window opacity restored to $DEFAULT_INACTIVE_OPACITY"
fi
