#!/usr/bin/env bash

KEY="/org/gnome/desktop/interface/color-scheme"
current_value=$(dconf read "$KEY")

if [[ "$current_value" == "'prefer-dark'" ]]; then
    new_value="'prefer-light'"
    dconf write "/org/gnome/desktop/interface/gtk-theme" "'Adwaita'"

    notify-send -e -u "low" -t 2000 \
        -i weather-clear-symbolic \
        "Color Scheme Changed" "Set to Light Mode"
elif [[ "$current_value" == "'prefer-light'" ]]; then
    new_value="'prefer-dark'"
    dconf write "/org/gnome/desktop/interface/gtk-theme" "'Adwaita-dark'"

    notify-send -e -u "low" -t 2000 \
        -i weather-clear-night-symbolic \
        "Color Scheme Changed" "Set to Dark Mode"
else
    new_value="'prefer-dark'"
    dconf write "/org/gnome/desktop/interface/gtk-theme" "'Adwaita-dark'"

    notify-send -e -u "low" -t 2000 \
        -i preferences-desktop-theme-symbolic \
        "Color Scheme Changed" "Set to Dark Mode (Default)"
fi

dconf write "$KEY" "$new_value"
