#!/bin/sh

systemctl --user restart pipewire

exec ~/.scripts/dual-audio-output.sh
