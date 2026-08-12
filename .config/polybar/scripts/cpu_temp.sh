#!/bin/bash

# Extract AMD Tctl temperature
temp=$(sensors | awk '/Tctl/ {print $2}')

echo "$temp"
