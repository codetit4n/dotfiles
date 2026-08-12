#!/bin/bash

SCRIPT_DIR="$(dirname "$0")"
MAX_LEN=60
FRAME_DELAY=0.12

FRAMES=(
    "▂▄"
    "▄▆"
    "▆█"
    "█▆"
    "▆▄"
    "▄▂"
)

truncate_text() {
    local text="$1"
    local max="$2"

    if (( ${#text} > max )); then
        printf '%s...' "${text:0:$((max - 3))}"
    else
        printf '%s' "$text"
    fi
}

while true; do
    status="$("$SCRIPT_DIR/get_spotify_status.sh" --status)"

    if [[ "$status" == "Playing" ]]; then
        text=$(playerctl --player=spotify metadata --format '{{ title }} - {{ artist }}' 2>/dev/null)

        text=$(truncate_text "$text" $((MAX_LEN - 5)))

        for frame in "${FRAMES[@]}"; do
            current_status=$(playerctl --player=spotify status 2>/dev/null)

            [[ "$current_status" != "Playing" ]] && break

            printf '%s %s 󰓇 \n' "$frame" "$text"
            sleep "$FRAME_DELAY"
        done

    elif [[ "$status" == "Paused" ]]; then
        text=$(playerctl --player=spotify metadata --format '{{ title }} - {{ artist }}' 2>/dev/null)
        text=$(truncate_text "$text" $((MAX_LEN - 5)))

        printf ' %s 󰓇 \n' "$text"

        sleep 0.25

    else
        printf '\n'
        sleep 1
    fi
done
