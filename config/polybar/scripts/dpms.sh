#!/bin/sh

get_state() {
  state=`cat ~/.scripts/screensaver/state`

  if [ $state == "on" ]; then
      echo ""
  else
      echo "%{F#707880}%{F-}"
  fi
}

get_state

inotifywait -m -q -e modify ~/.scripts/screensaver/state | while read -r; do
  get_state
done
