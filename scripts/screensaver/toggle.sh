#!/bin/bash

state=$(cat ~/.scripts/screensaver/state)
dim_screen_delay=`~/.settings/getconfig.sh system.dim_screen_delay`
lock_session_delay=`~/.settings/getconfig.sh system.lock_session_delay`
dpms=$((lock_session_delay + 40))
lock_session_wait=$((lock_session_delay - dim_screen_delay))

# check toggle option
if [ "$1" = "toggle" ]; then
  if [ "$state" = "on" ]; then
    echo "off" > ~/.scripts/screensaver/state
    xset s off -dpms
    dunstify "Screen saver" "Disabled"
  else
    echo "on" > ~/.scripts/screensaver/state
    xset s $dim_screen_delay $lock_session_wait
    xset dpms $dpms $dpms $dpms
    dunstify "Screen saver" "Enabled"
fi
elif [ "$1" = "state" ]; then
    echo $state
fi
