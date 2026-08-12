#!/usr/bin/env bash

current=$(
    pactl get-sink-volume @DEFAULT_SINK@ 2>/dev/null |
        awk -F'/' 'NR==1 {
            gsub(/[ %]/, "", $2)
            print $2
        }'
)

yad \
    --scale \
    --title="Volume" \
    --text="Volume Control" \
    --min-value=0 \
    --max-value=100 \
    --value="$current" \
    --step=1 \
    --print-partial \
    --width=900 \
    --height=50 \
    --center \
    --button="Close":0 2>/dev/null |
while read -r volume; do
    volume=${volume%%.*}

    [[ "$volume" =~ ^[0-9]+$ ]] || continue

    pactl set-sink-volume @DEFAULT_SINK@ "${volume}%"
done
