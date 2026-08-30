#!/usr/bin/env bash

FA='%{T5}'
RESET='%{T-}'

MOUSE="${FA}󰍽${RESET}"

BATTERY_LOW="${FA}${RESET}"
BATTERY_HALF="${FA}${RESET}"
BATTERY_HIGH="${FA}${RESET}"
BATTERY_FULL="${FA}${RESET}"

output="$(openlogi list 2>/dev/null)"

battery="$(
    printf '%s\n' "$output" |
        grep -A2 "MX Master 3S" |
        grep -oE 'battery=[0-9]+%' |
        head -n1 |
        grep -oE '[0-9]+'
)"

if [[ -z "$battery" ]]; then
    exit 0
fi

if (( battery <= 25 )); then
    battery_icon="$BATTERY_LOW"
elif (( battery <= 50 )); then
    battery_icon="$BATTERY_HALF"
elif (( battery <= 75 )); then
    battery_icon="$BATTERY_HIGH"
else
    battery_icon="$BATTERY_FULL"
fi

echo "${MOUSE} [${battery_icon} ${battery}%]"
