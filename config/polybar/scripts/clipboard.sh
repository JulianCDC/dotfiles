#!/bin/sh

rofi -modi "clipboard:greenclip print" -show clipboard -run-command '{cmd}' -theme "~/.config/rofi/themes/custom/text-only.rasi"
