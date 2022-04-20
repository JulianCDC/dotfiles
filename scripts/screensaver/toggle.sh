#!/bin/bash

state=$(cat ~/.scripts/screensaver/state)

# check toggle option
if [ "$1" = "toggle" ]; then
  if [ "$state" = "on" ]; then
    echo "off" > ~/.scripts/screensaver/state
    xset s off -dpms
    dunstify "Screen saver" "Disabled"
  else
    echo "on" > ~/.scripts/screensaver/state
    xset s 300 600 dpms 300 600 700
    dunstify "Screen saver" "Enabled"
fi
elif [ "$1" = "state" ]; then
    echo $state
fi

