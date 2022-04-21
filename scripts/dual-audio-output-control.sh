#!/bin/sh

if [ "$1" = "increase" ]; then
  pactl set-sink-volume chat-sink +2%
elif [ "$1" = "decrease" ]; then
  pactl set-sink-volume chat-sink -2%
elif [ "$1" = "mute" ]; then
  pactl set-sink-mute chat-sink toggle
elif [ "$1" = "toggle" ]; then
  pactl set-sink-mute chat-sink toggle
fi
