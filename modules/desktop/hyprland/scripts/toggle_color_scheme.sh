#!/usr/bin/env bash

KEY="/org/gnome/desktop/interface/color-scheme"
current_value=$(dconf read "$KEY")

if [[ "$current_value" == "'prefer-dark'" ]]; then
    new_value="'prefer-light'"
    notify-send -e -u "low" -t 1000 \
        -i weather-clear-symbolic \
        "Color Scheme Changed" "Set to Light Mode"
elif [[ "$current_value" == "'prefer-light'" ]]; then
    new_value="'prefer-dark'"
    notify-send -e -u "low" -t 1000 \
        -i weather-clear-night-symbolic \
        "Color Scheme Changed" "Set to Dark Mode"
else
    new_value="'prefer-dark'"
    notify-send -e -u "low" -t 1000 \
        -i preferences-desktop-theme-symbolic \
        "Color Scheme Changed" "Set to Dark Mode (Default)"
fi

dconf write "$KEY" "$new_value"
