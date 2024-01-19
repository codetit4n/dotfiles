#!/bin/sh

case "$1" in
    --popup)
        yad=$(yad --width 300 --entry --undecorated --title "Powermenu" --image=gnome-shutdown --text "Choose an action:" --entry-text "Shutdown" "Reboot" "Logout" "Lock")

        case "$yad" in
            Shutdown)
                /sbin/shutdown -h now
                ;;
            Reboot)
                /sbin/reboot
                ;;
            Logout)
                /sbin/pkill -KILL -u $USER
                ;;
            Lock)
                ~/.config/scripts/lock
                ;;
        esac
        ;;
    *)
        echo "#1"
        ;;
esac
