#!/usr/bin/env bash

mkdir -p "$HOME/Pictures/Screenshots"

file="$HOME/Pictures/Screenshots/Screenshot-$(date +%s).png"

if maim -s "$file"; then
    xclip -selection clipboard -t image/png -i "$file"
fi
