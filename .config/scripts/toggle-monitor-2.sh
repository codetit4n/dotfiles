#!/bin/bash
# Get current workspace name
current_ws=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused).name')
# Get previous workspace (the one that was focused before the current)
prev_ws=$(i3-msg -t get_workspaces | jq -r '.[] | select(.visible==true and .focused==false).name')
if [ "$current_ws" = "10" ]; then
  # Go back to previous workspace
  i3-msg "workspace $prev_ws"
else
  i3-msg "workspace 10"
fi
