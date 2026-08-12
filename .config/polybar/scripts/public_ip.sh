#!/usr/bin/env bash

CACHE_DIR="/tmp/polybar-public-ip"

IPV4_FILE="$CACHE_DIR/ipv4"
IPV6_FILE="$CACHE_DIR/ipv6"
CACHE_TIME_FILE="$CACHE_DIR/updated"

REVEAL_FILE="$CACHE_DIR/reveal"
REFRESH_FILE="$CACHE_DIR/refreshing"

INTERFACE="enp42s0"

CACHE_TTL=1800
REVEAL_TIME=15

GREEN='%{F#4CAF50}'
RED='%{F#FF4D4D}'
YELLOW='%{F#FFEA00}'
RESET='%{F-}'

SCRIPT="$HOME/.config/polybar/scripts/public_ip.sh"

mkdir -p "$CACHE_DIR"

get_public_ipv4() {
    curl -4 -s --max-time 4 https://api.ipify.org
}

get_public_ipv6() {
    curl -6 -s --max-time 4 https://api64.ipify.org
}

is_connected() {
    [[ "$(cat "/sys/class/net/$INTERFACE/operstate" 2>/dev/null)" == "up" ]]
}

cache_expired() {
    [[ ! -f "$CACHE_TIME_FILE" ]] && return 0

    local updated
    local now

    updated=$(cat "$CACHE_TIME_FILE" 2>/dev/null)
    now=$(date +%s)

    [[ -z "$updated" ]] && return 0

    (( now - updated >= CACHE_TTL ))
}

refresh_cache() {
    touch "$REFRESH_FILE"

    local ipv4
    local ipv6

    ipv4=$(get_public_ipv4)
    ipv6=$(get_public_ipv6)

    if [[ -n "$ipv4" ]]; then
        printf '%s' "$ipv4" > "$IPV4_FILE"
    fi

    if [[ -n "$ipv6" ]]; then
        printf '%s' "$ipv6" > "$IPV6_FILE"
    fi

    # Update cache timestamp if at least one lookup succeeded
    if [[ -n "$ipv4" || -n "$ipv6" ]]; then
        date +%s > "$CACHE_TIME_FILE"
    fi

    rm -f "$REFRESH_FILE"
}

reveal_ip() {
    local version="$1"

    if ! is_connected; then
        exit 1
    fi

    # Automatically refresh stale cache
    if cache_expired; then
        refresh_cache
    fi

    if [[ "$version" == "v4" ]]; then
        [[ -f "$IPV4_FILE" ]] || exit 1
    else
        [[ -f "$IPV6_FILE" ]] || exit 1
    fi

    printf '%s' "$version" > "$REVEAL_FILE"

    # Automatically hide after 15 seconds
    (
        sleep "$REVEAL_TIME"

        if [[ "$(cat "$REVEAL_FILE" 2>/dev/null)" == "$version" ]]; then
            rm -f "$REVEAL_FILE"
        fi
    ) &

    exit 0
}

copy_revealed_ip() {
    [[ -f "$REVEAL_FILE" ]] || exit 0

    local reveal_type
    local ip

    reveal_type=$(cat "$REVEAL_FILE" 2>/dev/null)

    if [[ "$reveal_type" == "v4" && -f "$IPV4_FILE" ]]; then
        ip=$(cat "$IPV4_FILE")

    elif [[ "$reveal_type" == "v6" && -f "$IPV6_FILE" ]]; then
        ip=$(cat "$IPV6_FILE")

    else
        exit 0
    fi

    printf '%s' "$ip" | xclip -selection clipboard

    if [[ $? -eq 0 ]]; then
        notify-send \
            -a "Polybar" \
            -i network-workgroup \
            "IP copied" \
            "Public ${reveal_type^^} address copied to clipboard."
    fi
}

case "$1" in

    --reveal-v4)
        yad \
            --title="Public IPv4" \
            --image="network-workgroup" \
            --text="Reveal public IPv4 address?" \
            --button="Reveal":2 \
            --button="Cancel":1 \
            --width=600 \
            --height=70 \
            --center

        [[ $? -eq 2 ]] || exit 0

        reveal_ip "v4"
        ;;

    --reveal-v6)
        yad \
            --title="Public IPv6" \
            --image="network-workgroup" \
            --text="Reveal public IPv6 address?" \
            --button="Reveal":2 \
            --button="Cancel":1 \
            --width=600 \
            --height=70 \
            --center

        [[ $? -eq 2 ]] || exit 0

        reveal_ip "v6"
        ;;

    --refresh)
        # Hide currently displayed IP
        rm -f "$REVEAL_FILE"

        if ! is_connected; then
            exit 1
        fi

        refresh_cache
        ;;

    --hide)
        # Immediately hide displayed IP
        rm -f "$REVEAL_FILE"
        exit 0
        ;;

    --copy)
        copy_revealed_ip
        exit 0
        ;;

    *)
        #
        # Offline
        #
        if ! is_connected; then
            echo "${RED} OFFLINE${RESET}"
            exit 0
        fi

        #
        # Refreshing
        #
        if [[ -f "$REFRESH_FILE" ]]; then
            echo "${YELLOW} ONLINE ${RESET}"
            exit 0
        fi

        #
        # Revealed IPv4
        #
        if [[ -f "$REVEAL_FILE" ]]; then
            reveal_type=$(cat "$REVEAL_FILE" 2>/dev/null)

            if [[ "$reveal_type" == "v4" && -f "$IPV4_FILE" ]]; then
                ip=$(cat "$IPV4_FILE")

                echo "${GREEN}${RESET} %{A1:$SCRIPT --copy:}${ip}%{A}"

                exit 0
            fi

            #
            # Revealed IPv6
            #
            if [[ "$reveal_type" == "v6" && -f "$IPV6_FILE" ]]; then
                ip=$(cat "$IPV6_FILE")

                echo "${GREEN}${RESET} %{A1:$SCRIPT --copy:}${ip}%{A}"

                exit 0
            fi
        fi

        #
        # Normal online state
        #
        echo "${GREEN} ONLINE${RESET}"
        ;;
esac
