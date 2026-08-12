#!/usr/bin/env bash

INTERFACE="enp42s0"

RX_FILE="/sys/class/net/$INTERFACE/statistics/rx_bytes"
TX_FILE="/sys/class/net/$INTERFACE/statistics/tx_bytes"
STATE_FILE="/tmp/polybar-network-speed-$INTERFACE"

if [[ ! -r "$RX_FILE" || ! -r "$TX_FILE" ]]; then
    echo "↓0.0M ↑0.0M"
    exit 0
fi

rx_now=$(cat "$RX_FILE")
tx_now=$(cat "$TX_FILE")
now=$(date +%s%N)

if [[ ! -f "$STATE_FILE" ]]; then
    printf '%s %s %s\n' "$rx_now" "$tx_now" "$now" > "$STATE_FILE"
    echo "↓0.0M ↑0.0M"
    exit 0
fi

read -r rx_old tx_old time_old < "$STATE_FILE"

printf '%s %s %s\n' "$rx_now" "$tx_now" "$now" > "$STATE_FILE"

elapsed_ns=$((now - time_old))

if (( elapsed_ns <= 0 )); then
    echo "↓0.0M ↑0.0M"
    exit 0
fi

rx_diff=$((rx_now - rx_old))
tx_diff=$((tx_now - tx_old))

# Handle counter reset/interface restart
(( rx_diff < 0 )) && rx_diff=0
(( tx_diff < 0 )) && tx_diff=0

awk \
    -v rx="$rx_diff" \
    -v tx="$tx_diff" \
    -v ns="$elapsed_ns" \
    'BEGIN {
        seconds = ns / 1000000000

        # bytes/sec -> bits/sec -> megabits/sec
        down = (rx * 8) / seconds / 1000000
        up   = (tx * 8) / seconds / 1000000

        printf "↓%.1fM ↑%.1fM\n", down, up
    }'
