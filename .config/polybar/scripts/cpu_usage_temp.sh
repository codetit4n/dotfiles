#!/usr/bin/env bash
set -euo pipefail

state_file="/tmp/polybar_cpu_stat_${UID}"

# Read current aggregate cpu line
read -r _ user nice system idle iowait irq softirq steal guest guest_nice < /proc/stat

idle_all=$((idle + iowait))
total=$((user + nice + system + idle + iowait + irq + softirq + steal))

if [[ -f "$state_file" ]]; then
  read -r prev_total prev_idle < "$state_file" || true
  diff_total=$((total - prev_total))
  diff_idle=$((idle_all - prev_idle))

  if (( diff_total > 0 )); then
    usage=$(( (100 * (diff_total - diff_idle)) / diff_total ))
  else
    usage=0
  fi
else
  usage=0
fi

printf "%s %s\n" "$total" "$idle_all" > "$state_file"

# Temp (AMD Tctl)
raw_temp=$(sensors 2>/dev/null | awk '/Tctl/ {print $2; exit}')

if [[ -z "${raw_temp:-}" ]]; then
  temp="N/A"
else
  # Remove leading +
  raw_temp="${raw_temp#+}"

  # Remove °C
  numeric_temp="${raw_temp/°C/}"

  # Check if negative
  if [[ "$numeric_temp" == -* ]]; then
    temp="ERROR"
  else
    # Truncate decimal part (integer only)
    temp="${numeric_temp%%.*}°C"
  fi
fi

echo "${usage}% [${temp}]"
