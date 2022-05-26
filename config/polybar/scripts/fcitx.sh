#!/bin/sh

INPUT=`qdbus "org.fcitx.Fcitx5" "/controller" "org.fcitx.Fcitx.Controller1.CurrentInputMethod"`

if [[ "$INPUT" == "keyboard-fr" ]]; then
    echo "FR"
elif [[ "$INPUT" == "mozc" ]]; then
    echo "日本語"
elif [[ "$INPUT" == "" ]]; then
    echo "NONE"
fi
