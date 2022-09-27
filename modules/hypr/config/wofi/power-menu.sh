#!/usr/bin/env sh

entries=" Shutdown\n Reboot\n Suspend"

selected=$(echo -e $entries | wofi --width 250 --height 210 --dmenu | awk '{print tolower($2)}')

case $selected in
  suspend)
    exec systemctl suspend;;
  reboot)
    exec systemctl reboot;;
  shutdown)
    exec systemctl poweroff -i;;
esac
