#!/bin/sh

get_updates() {
    updates=`cat ~/.scripts/updates-checker/updates.txt`

    if [ "$updates" -gt 0 ]; then
        echo " $updates"
    else
        echo ""
    fi
}

get_updates

inotifywait -m -q -e modify ~/.scripts/updates-checker/updates.txt | while read -r; do
  get_updates
done
