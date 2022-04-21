#!/bin/sh

current_focused=`cat current-focused`

if [ "$1" == "get" ]; then
    echo $current_focused
elif [ "$1" == "change" ]; then
    if [ "$2" == "raise" ]; then
      ~/.scripts/dual-audio-output-control.sh increase $current_focused
    elif [ "$2" == "lower" ]; then
      ~/.scripts/dual-audio-output-control.sh decrease $current_focused
    elif [ "$2" == "toggle" ]; then
      ~/.scripts/dual-audio-output-control.sh toggle $current_focused
    fi
elif [ "$1" == "cycle" ]; then
  if [ $current_focused == "game" ]; then
    echo "chat" > ./current-focused
  elif [ $current_focused == "chat" ]; then
    echo "music" > ./current-focused
  elif [ $current_focused == "music" ]; then
    echo "game" > ./current-focused
  fi
fi
