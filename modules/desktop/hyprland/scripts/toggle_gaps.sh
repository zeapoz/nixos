#!/usr/bin/env bash

DEFAULT_GAPS_IN="6"
DEFAULT_GAPS_OUT="12"
DEFAULT_ROUNDING=12

CURRENT_GAPS_IN=$(hyprctl -j getoption general:gaps_in | jq -r '.custom')
CURRENT_GAPS_OUT=$(hyprctl -j getoption general:gaps_out | jq -r '.custom')

if [ "$CURRENT_GAPS_IN" == "0 0 0 0" ] && [ "$CURRENT_GAPS_OUT" == "0 0 0 0" ]; then
    hyprctl --batch "keyword general:gaps_in $DEFAULT_GAPS_IN; keyword general:gaps_out $DEFAULT_GAPS_OUT; keyword decoration:rounding $DEFAULT_ROUNDING"
    notify-send -e -u low -t 1000 \
        -i preferences-system-windows \
        "Gaps Restored" "Outer gaps set to $DEFAULT_GAPS_OUT"
else
    hyprctl --batch "keyword general:gaps_in 0; keyword general:gaps_out 0; keyword decoration:rounding 0"
    notify-send -e -u low -t 1000 \
        -i preferences-system-windows \
        "Gaps Removed" "Outer gaps removed"
fi
