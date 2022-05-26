#!/bin/sh

i3-msg rename workspace to \""$(rofi -dmenu -theme ~/.config/rofi/themes/custom/input.rasi -p 'New workspace name')"\"
