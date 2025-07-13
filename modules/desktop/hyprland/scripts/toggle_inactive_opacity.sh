#/usr/bin/env bash

DEFAULT_INACTIVE_OPACITY=0.8

CURRENT_INACTIVE_OPACITY=$(hyprctl -j getoption decoration:inactive_opacity | jq -r '.float')

if [ "$CURRENT_INACTIVE_OPACITY" == "1.000000" ]; then
    hyprctl --batch "keyword decoration:inactive_opacity $DEFAULT_INACTIVE_OPACITY"
else
    hyprctl --batch "keyword decoration:inactive_opacity 1"
fi
