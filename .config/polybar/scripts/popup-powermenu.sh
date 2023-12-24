#!/bin/sh

case "$1" in
    --popup)
        yad=$(yad --width 300 --entry --undecorated --title "System Logout" --image=gnome-shutdown --text "Choose action:" --entry-text "Shutdown" "Reboot" "Logout" "Lock")

        case "$yad" in
            Shutdown)
                shutdown -h now
                ;;
            Reboot)
                reboot
                ;;
            Lock)
                ~/.config/scripts/lock
                ;;
            Logout)
                kill -9 -1
                ;;
        esac
        ;;
    *)
        echo "#1"
        ;;
esac
