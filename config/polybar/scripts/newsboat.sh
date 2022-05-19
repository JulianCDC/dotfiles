#!/bin/sh

get_updates() {
    unread=`cat ~/.scripts/rss/updates.txt`

    if [ "$unread" -gt 0 ]; then
        echo " $unread"
    else
        echo ""
    fi
}

get_updates

inotifywait -m -q -e modify ~/.scripts/rss/updates.txt | while read -r; do
  get_updates
done
