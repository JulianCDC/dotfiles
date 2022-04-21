#!/bin/sh

game_volume=`pactl get-sink-volume game-sink | cut -d'/' -f2 | cut -d' ' -f3`

if [ -z $game_volume ]; then
    game_volume=`pactl get-sink-volume game-sink | cut -d'/' -f2 | cut -d' ' -f2`
fi

chat_volume=`pactl get-sink-volume chat-sink | cut -d'/' -f2 | cut -d' ' -f3
`

if [ -z $chat_volume ]; then
    chat_volume=`pactl get-sink-volume chat-sink | cut -d'/' -f2 | cut -d' ' -f2`
fi

game_muted=`pactl get-sink-mute game-sink | cut -d' ' -f2`
chat_muted=`pactl get-sink-mute chat-sink | cut -d' ' -f2`

chat_icon=
game_icon=

chat_text=" $chat_volume"
game_text=" $game_volume"

if [ $chat_muted == "yes" ]; then
    chat_text=""
    chat_icon="%{F#707880}%{F-}"
fi

if [ $game_muted == "yes" ]; then
    game_text=""
    game_icon="%{F#707880}%{F-}"
fi

echo "$game_icon$game_text $chat_icon$chat_text"
