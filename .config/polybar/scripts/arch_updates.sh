#!/bin/sh

if ! updates_arch=$(checkupdates-with-aur 2>/dev/null | wc -l ); then
    updates_arch=0
fi

#if ! updates_aur=$(yay -Qu 2>/dev/null | wc -l); then
#    updates_aur=0
#fi

#updates=$(("$updates_arch" + "$updates_aur"))
updates=$(("$updates_arch"))

if [ "$updates" -gt 0 ]; then
    echo " $updates"
else
    echo ""
fi
