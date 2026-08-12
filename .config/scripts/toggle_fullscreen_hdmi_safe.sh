#!/usr/bin/env bash
set -euo pipefail

# focused workspace name (works without jq)
ws="$(
  i3-msg -t get_workspaces \
  | sed -n 's/.*"name":"\([^"]*\)".*"focused":true.*/\1/p'
)"

# If we're on HDMI-1 workspaces (9/10), keep the top gap after toggling fullscreen
if [ "$ws" = "9" ] || [ "$ws" = "10" ]; then
  i3-msg "fullscreen toggle" >/dev/null
  # Re-apply your reserved space for polybar2 (adjust 33 if you change bar height)
  i3-msg "gaps top current set 33" >/dev/null
else
  i3-msg "fullscreen toggle" >/dev/null
fi

