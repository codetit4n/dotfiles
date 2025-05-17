#!/bin/bash

DEVICE_NAME="Apple Inc. Magic Trackpad 2"

# Get the dynamic device ID
DEVICE_ID=$(xinput list | grep "$DEVICE_NAME" | grep -o 'id=[0-9]*' | cut -d= -f2)

# If not found, exit
if [ -z "$DEVICE_ID" ]; then
    echo "Trackpad not found!"
    exit 1
fi

# Apply your settings
xinput set-prop "$DEVICE_ID" "libinput Tapping Enabled" 1
xinput set-prop "$DEVICE_ID" "libinput Tapping Drag Enabled" 0
xinput set-prop "$DEVICE_ID" "libinput Tapping Drag Lock Enabled" 0
xinput set-prop "$DEVICE_ID" "libinput Natural Scrolling Enabled" 1
xinput set-prop "$DEVICE_ID" "libinput Click Method Enabled" 0 1         # buttonareas
xinput set-prop "$DEVICE_ID" "libinput Scrolling Pixel Distance" 50
xinput set-prop "$DEVICE_ID" "libinput Accel Speed" 0.25

pkill libinput-gestures 2>/dev/null
sleep 1
libinput-gestures &
