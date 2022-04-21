#!/bin/sh

sink="game-sink"

if [ "$2" = "game" ]; then
  sink="game-sink"
elif [ "$2" = "chat" ]; then
  sink="chat-sink"
fi

if [ "$1" = "increase" ]; then
  pactl set-sink-volume $sink +5%
elif [ "$1" = "decrease" ]; then
  pactl set-sink-volume $sink -5%
elif [ "$1" = "mute" ]; then
  pactl set-sink-mute $sink toggle
elif [ "$1" = "toggle" ]; then
  pactl set-sink-mute $sink toggle
fi
