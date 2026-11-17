#!/bin/sh
# Battery status for hyprlock: Nerd Font icon + percentage (Pango markup).
# Prints nothing on machines without a battery, so the label just stays empty.

bat=$(ls -d /sys/class/power_supply/BAT* 2>/dev/null | head -n1)
[ -n "$bat" ] || exit 0

cap=$(cat "$bat/capacity")
status=$(cat "$bat/status")

case "$status" in
  Charging)          icon="󰂄" ;;
  Full|"Not charging") icon="󰚥" ;;
  *)
    i=$(( cap / 10 ))
    set -- 󰂎 󰁺 󰁻 󰁼 󰁽 󰁾 󰁿 󰂀 󰂁 󰂂 󰁹
    shift "$i"; icon=$1
    ;;
esac

# Low battery while discharging: warning icon + salmon, like the input fail colour.
if [ "$status" = "Discharging" ] && [ "$cap" -le 20 ]; then
  echo "<span foreground='#ff7b72'>󰂃 ${cap}%</span>"
else
  echo "$icon ${cap}%"
fi
