#!/usr/bin/env bash

command="$1"
amount="${2:-6}"

display_history() {
    local history
    local entries

    history="$(dunstctl history)"

    entries="$(
        echo "$history" |
            jq -r '
                .data[0][]
                | [
                    (.appname.data // "Unknown"),
                    (.summary.data // ""),
                    (.body.data // "")
                  ]
                | @tsv
            ' |
            head -n "$amount" |
            awk -F '\t' '
                {
                    printf "%s — %s", $1, $2

                    if ($3 != "") {
                        printf "\n%s", $3
                    }

                    printf "\n\n"
                }
            '
    )"

    if [[ -z "$entries" ]]; then
        entries="No notifications"
    fi

    printf '%s\n' "$entries" |
        rofi \
            -dmenu \
            -i \
            -p "Notifications" \
            -mesg "Last $amount notifications"
}

status() {
    local history_count

    history_count="$(dunstctl count history)"

    if (( history_count > 0 )); then
        # Bright light blue bell + notification count
        printf '%%{F#7DD3FC} %d%%{F-}\n' "$history_count"
    else
        # Dark grey bell, no count
        printf '%%{F#888888}%%{F-}\n'
    fi
}

toggle() {
    dunstctl set-paused toggle
}

close_one() {
    dunstctl close
}

clear_history() {
    dunstctl close-all
    dunstctl history-clear
}

case "$command" in
    status)
        status
        ;;

    display-history)
        display_history
        ;;

    toggle)
        toggle
        ;;

    close)
        close_one
        ;;

    clear)
        clear_history
        ;;

    *)
        echo "Usage:"
        echo "  $0 status"
        echo "  $0 display-history [count]"
        echo "  $0 toggle"
        echo "  $0 close"
        echo "  $0 clear"
        exit 1
        ;;
esac
