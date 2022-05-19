#!/bin/sh

while true; do
  sleep 300

  unread=`newsboat -x reload && newsboat -x print-unread | cut -d' ' -f1`

  echo $unread > ~/.scripts/rss/updates.txt
done
