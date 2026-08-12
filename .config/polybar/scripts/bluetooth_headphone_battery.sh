#!/usr/bin/env bash

sink=$(pactl get-default-sink 2>/dev/null)

# Only continue if the current audio output is Bluetooth
[[ "$sink" == bluez_output.* ]] || exit 0

# Example:
# bluez_output.XX_XX_XX_XX_XX_XX.1
mac=$(echo "$sink" \
    | sed -E 's/^bluez_output\.([0-9A-Fa-f_]{17}).*/\1/' \
    | tr '_' ':')

[[ "$mac" =~ ^([0-9A-Fa-f]{2}:){5}[0-9A-Fa-f]{2}$ ]] || exit 0

battery=$(bluetoothctl info "$mac" 2>/dev/null \
    | sed -nE 's/.*Battery Percentage:.*\(([0-9]+)\).*/\1/p')

[[ -n "$battery" ]] || exit 0

echo " ${battery}%"
