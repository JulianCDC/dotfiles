#!/bin/sh

unread=`newsboat -x reload && newsboat -x print-unread | cut -d' ' -f1`

echo $unread > ~/.scripts/rss/updates.txt
