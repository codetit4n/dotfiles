#!/bin/bash

DEVICE="/org/freedesktop/UPower/devices/keyboard_dev_EC_9E_C3_64_C1_70"

# Check if the device exists and is present
if upower -i "$DEVICE" 2>/dev/null | grep -q "present: *yes"; then
    # Extract percentage value and print with icon and %
    PERCENT=$(upower -i "$DEVICE" | awk '/percentage/ { gsub("%", "", $2); print $2 }')
    echo "🖮 ${PERCENT}%"
else
    # Output a space so Polybar doesn’t break
    echo " "
fi
