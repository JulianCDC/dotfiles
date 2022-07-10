#!/bin/sh

get_state() {
  state=`config_manager --cli get energy autolock`

  if [ $state == "true" ]; then
      echo ""
  else
      echo "%{F#707880}%{F-}"
  fi
}

get_state

inotifywait -m -q -e modify ~/.config/JulianCDC | while read -r; do
  get_state
done
