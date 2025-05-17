#!/bin/bash

PID_FILE="/tmp/ffmpeg_screen_recording.pid"

if [ -f "$PID_FILE" ]; then
  # If PID file exists, kill the recording process
  PID=$(cat "$PID_FILE")
  if kill "$PID" > /dev/null 2>&1; then
    notify-send -a "ffmpeg" "🔴🖥️ Screen Recording Stopped"
  fi
  rm -f "$PID_FILE"
  exit 0
fi

# Start new recording

export DISPLAY=:0

# Get the selected region using slop
GEOM=$(slop -f "%x %y %w %h")
read -r X Y W H <<< "$GEOM"

# Round width and height down to even numbers
W=$((W - W % 2))
H=$((H - H % 2))

# Check if selection is valid
if [ -z "$X" ] || [ -z "$W" ] || [ "$W" -le 0 ] || [ "$H" -le 0 ]; then
  notify-send -a "ffmpeg" "❌ Invalid region selected"
  exit 1
fi

# Output file
mkdir -p "$HOME/Videos/Recordings"
OUTFILE="$HOME/Videos/Recordings/recording_$(date +%Y-%m-%d_%H-%M-%S).mp4"

# Start recording in the background
ffmpeg \
  -video_size "${W}x${H}" \
  -framerate 30 \
  -f x11grab \
  -i ":0.0+${X},${Y}" \
  -c:v libx264 \
  -preset ultrafast \
  -tune zerolatency \
  -pix_fmt yuv420p \
  "$OUTFILE" > /dev/null 2>&1 &

# Save the PID
echo $! > "$PID_FILE"
notify-send -a "ffmpeg" "🔴🖥️ Screen Recording Started"

