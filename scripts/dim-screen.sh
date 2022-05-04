#!/bin/sh

fade_brightness() {
    I=0
    while [ $I -lt 10 ]; do
        brightnessctl set 5%-
        sleep 0.05
        ((I = I + 1));
    done
}

trap 'exit 0' TERM INT
trap "brightnessctl set 100%; kill %%" EXIT
fade_brightness
sleep 2147483647 &
wait
