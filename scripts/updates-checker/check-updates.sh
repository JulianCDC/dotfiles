#!/bin/sh

if ! updates_arch=$(checkupdates 2> /dev/null | wc -l ); then
    updates_arch=0
fi

if ! updates_aur=$(yay -Qum 2> /dev/null | wc -l); then
    updates_aur=0
fi

update_number=$((updates_arch + updates_aur))

old_updates=`cat ~/.scripts/updates-checker`
new_updates=$((update_number - old_updates))

if [ "$new_updates" -gt 0 ]; then
    dunstify "Updates" "$new_updates new updates"
fi

echo $update_number > ~/.scripts/updates-checker/updates.txt
