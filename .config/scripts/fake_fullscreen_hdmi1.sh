#!/usr/bin/env bash
set -euo pipefail

OUT="HDMI-1"
TOP_BAR_NAME="polybar-mypolybar2_HDMI-1"
BOT_BAR_NAME="polybar-mypolybar1_HDMI-1"
MARK="FAKEFS_HDMI1"

# Get output geometry like: 1620x2880+3840+0
geom="$(xrandr --query | awk -v o="$OUT" '
  $1==o && $2=="connected" {
    for (i=1;i<=NF;i++) if ($i ~ /^[0-9]+x[0-9]+\+[0-9]+\+[0-9]+$/) {print $i; exit}
  }'
)"

if [[ -z "${geom}" ]]; then
  # fallback: if HDMI-1 not found, just do normal fullscreen
  i3-msg "fullscreen toggle" >/dev/null
  exit 0
fi

W="${geom%%x*}"
rest="${geom#*x}"
H="${rest%%+*}"
rest2="${rest#*+}"
X="${rest2%%+*}"
Y="${rest2#*+}"

# Get top bar height and bottom bar height (fallback to your known values if lookup fails)
top_h="$(xwininfo -name "$TOP_BAR_NAME" 2>/dev/null | awk '/Height:/ {print $2; exit}' || true)"
bot_h="$(xwininfo -name "$BOT_BAR_NAME" 2>/dev/null | awk '/Height:/ {print $2; exit}' || true)"

: "${top_h:=63}"   # fallback from your xwininfo (mypolybar2 was 63px)
: "${bot_h:=72}"   # fallback from your xwininfo (mypolybar1 was 72px)

avail_h=$(( H - top_h - bot_h ))
avail_y=$(( Y + top_h ))

# Check if focused container already has the mark
if i3-msg -t get_tree | grep -q "\"marks\":\\[[^]]*\"$MARK\""; then
  # Turn OFF fake fullscreen
  i3-msg "unmark $MARK, floating disable, border pixel 3" >/dev/null
else
  # Turn ON fake fullscreen (fill HDMI-1 excluding bars)
  i3-msg "mark $MARK, floating enable, border pixel 0" >/dev/null
  i3-msg "move position ${X} ${avail_y}, resize set ${W} ${avail_h}" >/dev/null
fi

