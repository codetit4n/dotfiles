#!/usr/bin/env bash

FA='%{T5}'
RESET='%{T-}'

MUTED_GRAY='%{F#9A9A9A}'
FG_RESET='%{F-}'

# Speaker volume icons
VOLUME_LOW="${FA}${RESET}"
VOLUME_MID="${FA}${RESET}"
VOLUME_HIGH="${FA}${RESET}"

# Muted speaker icon
VOLUME_MUTED="${FA}${RESET}"

# Headphones
HEADPHONES="${FA}$(printf '\uf025')${RESET}"

# Battery icons
BATTERY_LOW="${FA}${RESET}"
BATTERY_HALF="${FA}${RESET}"
BATTERY_HIGH="${FA}${RESET}"
BATTERY_FULL="${FA}${RESET}"


get_volume_icon() {
    local volume="$1"

    if (( volume <= 32 )); then
        echo "$VOLUME_LOW"
    elif (( volume <= 65 )); then
        echo "$VOLUME_MID"
    else
        echo "$VOLUME_HIGH"
    fi
}


get_battery_icon() {
    local battery="$1"

    if (( battery <= 25 )); then
        echo "$BATTERY_LOW"
    elif (( battery <= 50 )); then
        echo "$BATTERY_HALF"
    elif (( battery <= 75 )); then
        echo "$BATTERY_HIGH"
    else
        echo "$BATTERY_FULL"
    fi
}


get_battery() {
    local sink="$1"
    local mac

    mac=$(
        echo "$sink" |
            sed -E 's/^bluez_output\.([0-9A-Fa-f_]{17}).*/\1/' |
            tr '_' ':'
    )

    bluetoothctl info "$mac" 2>/dev/null |
        sed -nE 's/.*Battery Percentage:.*\(([0-9]+)\).*/\1/p'
}


get_active_port() {
    pactl list sinks 2>/dev/null |
        awk '
            $1 == "Name:" {
                current_sink = $2
            }

            current_sink == ENVIRON["DEFAULT_SINK"] &&
            $1 == "Active" &&
            $2 == "Port:" {
                print $3
                exit
            }
        '
}


print_status() {
    volume=$(
        pactl get-sink-volume @DEFAULT_SINK@ 2>/dev/null |
            awk -F'/' 'NR==1 {
                gsub(/[ %]/, "", $2)
                print $2
            }'
    )

    muted=$(
        pactl get-sink-mute @DEFAULT_SINK@ 2>/dev/null |
            awk '{print $2}'
    )

    sink=$(pactl get-default-sink 2>/dev/null)

    #
    # Bluetooth headphones
    #
    if [[ "$sink" == bluez_output.* ]]; then
        battery=$(get_battery "$sink")

        if [[ -n "$battery" ]]; then
            battery_icon=$(get_battery_icon "$battery")
            battery_text="[${battery_icon} ${battery}%]"
        else
            battery_text=""
        fi

        if [[ "$muted" == "yes" ]]; then
            if [[ -n "$battery_text" ]]; then
                echo "${MUTED_GRAY}${HEADPHONES} x ${battery_text}${FG_RESET}"
            else
                echo "${MUTED_GRAY}${HEADPHONES} x${FG_RESET}"
            fi

            return
        fi

        if [[ -n "$battery_text" ]]; then
            echo "${HEADPHONES} ${volume}% ${battery_text}"
        else
            echo "${HEADPHONES} ${volume}%"
        fi

        return
    fi

    #
    # Wired / USB headphones
    #
    if [[ "$sink" == alsa_output.usb-* ]]; then
        if [[ "$muted" == "yes" ]]; then
            echo "${MUTED_GRAY}${HEADPHONES} x${FG_RESET}"
        else
            echo "${HEADPHONES} ${volume}%"
        fi

        return
    fi

    #
    # Normal speakers
    #
    if [[ "$muted" == "yes" ]]; then
        echo "${MUTED_GRAY}${VOLUME_MUTED} muted${FG_RESET}"
        return
    fi

    volume_icon=$(get_volume_icon "$volume")

    echo "$volume_icon ${volume}%"
}


# Initial state
print_status


# Instant updates
pactl subscribe 2>/dev/null |
while read -r event; do
    case "$event" in
        *"on sink"*|*"on server"*|*"on card"*)
            print_status
            ;;
    esac
done
