#!/bin/sh

current_focused=`cat ~/.config/polybar/scripts/focused-audio-output/current-focused`

game_volume=`pactl get-sink-volume game-sink | cut -d'/' -f2 | cut -d' ' -f3`

if [ -z $game_volume ]; then
    game_volume=`pactl get-sink-volume game-sink | cut -d'/' -f2 | cut -d' ' -f2`
fi

chat_volume=`pactl get-sink-volume chat-sink | cut -d'/' -f2 | cut -d' ' -f3
`

if [ -z $chat_volume ]; then
    chat_volume=`pactl get-sink-volume chat-sink | cut -d'/' -f2 | cut -d' ' -f2`
fi

music_volume=`pactl get-sink-volume music-sink | cut -d'/' -f2 | cut -d' ' -f3
`

if [ -z $music_volume ]; then
    music_volume=`pactl get-sink-volume music-sink | cut -d'/' -f2 | cut -d' ' -f2`
fi

game_muted=`pactl get-sink-mute game-sink | cut -d' ' -f2`
chat_muted=`pactl get-sink-mute chat-sink | cut -d' ' -f2`
music_muted=`pactl get-sink-mute music-sink | cut -d' ' -f2`

chat_icon=
game_icon=
music_icon=

chat_text=" $chat_volume"
game_text=" $game_volume"
music_text=" $music_volume"

if [ $chat_muted == "yes" ]; then
    chat_text=""
    chat_icon="%{F#707880}%{F-}"
fi

if [ $game_muted == "yes" ]; then
    game_text=""
    game_icon="%{F#707880}%{F-}"
fi

if [ $music_muted == "yes" ]; then
    music_text=""
    music_icon="%{F#707880}%{F-}"
fi

combined_game_text="%{A4:~/.scripts/dual-audio-output-control.sh increase game:}%{A5:~/.scripts/dual-audio-output-control.sh decrease game:}%{A2:~/.scripts/dual-audio-output-control.sh toggle game:}$game_icon$game_text%{A}%{A}%{A}"
combined_chat_text="%{A4:~/.scripts/dual-audio-output-control.sh increase chat:}%{A5:~/.scripts/dual-audio-output-control.sh decrease chat:}%{A2:~/.scripts/dual-audio-output-control.sh toggle chat:}$chat_icon$chat_text%{A}%{A}%{A}"
combined_music_text="%{A4:~/.scripts/dual-audio-output-control.sh increase music:}%{A5:~/.scripts/dual-audio-output-control.sh decrease music:}%{A2:~/.scripts/dual-audio-output-control.sh toggle music:}$music_icon$music_text%{A}%{A}%{A}"

# if [ $current_focused == "game" ]; then
#     combined_game_text="%{+u}$combined_game_text%{u-}"
# elif [ $current_focused == "chat" ]; then
#     combined_chat_text="%{u#FFFFFF}$combined_chat_text%{u-}"
# elif [ $current_focused == "music" ]; then
#     combined_music_text="%{u#FFFFFF}$combined_music_text%{u-}"
# fi

echo "$combined_game_text $combined_chat_text $combined_music_text"
