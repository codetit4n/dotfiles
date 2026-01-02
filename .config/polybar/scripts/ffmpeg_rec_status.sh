#!/bin/bash

PID_FILE="/tmp/ffmpeg_screen_recording.pid"

# No PID file => no recording
if [ ! -f "$PID_FILE" ]; then
  echo ""
  exit 0
fi

PID="$(cat "$PID_FILE" 2>/dev/null || echo "")"

# Empty / broken PID => cleanup
if [ -z "$PID" ]; then
  rm -f "$PID_FILE"
  echo ""
  exit 0
fi

# If the PID is not alive, cleanup and hide REC
if ! kill -0 "$PID" 2>/dev/null; then
  rm -f "$PID_FILE"
  echo ""
  exit 0
fi

# Extra safety: make sure it's actually ffmpeg
if ! ps -p "$PID" -o comm= 2>/dev/null | grep -q "^ffmpeg$"; then
  rm -f "$PID_FILE"
  echo ""
  exit 0
fi

# At this point we are confident ffmpeg is running
echo "%{F#ff5555}⬤  REC%{F-}"
