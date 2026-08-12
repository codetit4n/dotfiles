#!/usr/bin/env bash
set -euo pipefail

BAR_TITLE="polybar-mypolybar2_HDMI-1"

# toggle fullscreen
i3-msg fullscreen toggle >/dev/null

# let the app restack itself
sleep 0.08

# raise the bar (EWMH)
wmctrl -a "$BAR_TITLE" >/dev/null 2>&1 || true

# IMPORTANT: return focus to the fullscreen container so your typing goes there
i3-msg focus child >/dev/null 2>&1 || true
