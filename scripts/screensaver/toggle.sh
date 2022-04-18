#!/bin/bash

state=$(cat ~/.scripts/screensaver/state)

if [ "$state" = "on" ]; then
  echo "off" > ~/.scripts/screensaver/state
  xset s off -dpms
  dunstify "Screen saver" "Disabled"
else
  echo "on" > ~/.scripts/screensaver/state
  xset s on dpms
  dunstify "Screen saver" "Enabled"
fi
