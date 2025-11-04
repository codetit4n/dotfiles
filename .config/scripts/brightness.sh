#!/bin/bash

DISPLAY=$1         # e.g., 1 or 2
TARGET_PERCENT=$2  # e.g., 50 for 50%
MIN_PERCENT=10

# Show usage and exit
usage() {
    echo "Usage: $0 <display_number> <brightness_percent>"
    echo "  <display_number>:    1 or 2"
    echo "  <brightness_percent>: Value between 10 and 100"
    exit 1
}

# Validate input
if [[ -z "$DISPLAY" || -z "$TARGET_PERCENT" ]]; then
    usage
fi

# Check if DISPLAY and TARGET_PERCENT are numbers
if ! [[ "$DISPLAY" =~ ^[0-9]+$ && "$TARGET_PERCENT" =~ ^[0-9]+$ ]]; then
    echo "Error: Arguments must be numeric."
    usage
fi

set_brightness() {
    OUTPUT=$(ddcutil --display "$DISPLAY" getvcp 10 2>/dev/null)

    MAX=$(echo "$OUTPUT" | awk -F '=' '/max value/ {gsub(/,/, "", $3); print $3}' | awk '{print $1}')

    if [[ -z "$MAX" ]]; then
        dunstify -a "Brightness" -r "999$DISPLAY" "❌ Failed to read brightness for display $DISPLAY"
        exit 1
    fi

    # Clamp target percentage between 10 and 100
    if [ "$TARGET_PERCENT" -lt "$MIN_PERCENT" ]; then
        TARGET_PERCENT=$MIN_PERCENT
    elif [ "$TARGET_PERCENT" -gt 100 ]; then
        TARGET_PERCENT=100
    fi

    # Convert percentage to actual brightness value
    NEW=$((MAX * TARGET_PERCENT / 100))

    ddcutil --display "$DISPLAY" setvcp 10 "$NEW"
}

set_brightness

