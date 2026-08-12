#!/usr/bin/env bash
set -euo pipefail

# Detect current workspace name
ws="$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true) | .name')"

# Only apply on HDMI-1 workspaces (9 and 10 in your config)
if [[ "$ws" != "9" && "$ws" != "10" ]]; then
  # fallback to real fullscreen for DP-0 workspaces
  i3-msg fullscreen toggle >/dev/null
  exit 0
fi

# Toggle a mark on the focused container to remember state
if i3-msg -t get_tree | jq -e '.. | objects | select(.focused?==true) | .marks[]? | select(.=="FAKEFS")' >/dev/null; then
  # Turn OFF fake fullscreen
  i3-msg 'unmark FAKEFS, border pixel 3, gaps top current set 42' >/dev/null
else
  # Turn ON fake fullscreen: remove border, remove gaps inside workspace (except bar gap)
  i3-msg 'mark FAKEFS, border pixel 0, gaps inner current set 0, gaps horizontal current set 0, gaps vertical current set 0' >/dev/null
fi

