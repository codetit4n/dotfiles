#!/bin/bash

# Get the currently focused workspace number
current_ws=$(i3-msg -t get_workspaces | jq '.[] | select(.focused==true).name')

# Remove quotes
current_ws=${current_ws//\"/}

# Toggle between current and workspace 10
if [ "$current_ws" == "10" ]; then
  # Go back to previous workspace stored in a temp file
  if [ -f /tmp/i3-prev-ws ]; then
    prev_ws=$(cat /tmp/i3-prev-ws)
    i3-msg workspace "$prev_ws"
  fi
else
  # Save current workspace and switch to 10
  echo "$current_ws" > /tmp/i3-prev-ws
  i3-msg workspace "10"
fi

