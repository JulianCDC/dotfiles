#!/bin/sh

# random_image_path=`find ~/.cache/lockscreen -type f | shuf -n 1`

lockscreen_folder=`config_manager --cli get appearance lockscreenconversionfolder`
slideshow_interval=`config_manager --cli get appearance lockscreenslideshowinterval`

pre_lock() {
  echo "locked" > ~/.scripts/energy/status.txt
}

post_lock() {
  echo "unlocked" > ~/.scripts/energy/status.txt
}

BLANK='#00000000'
CLEAR='#ffffff22'
DEFAULT='#FFFFFFcc'
TEXT='#FFFFFFee'
WRONG='#136ED7bb'
VERIFYING='#FFFFFFbb'

i3lock_options="--nofork -i $lockscreen_folder --slideshow-interval=$slideshow_interval --slideshow-random-selection --fill --insidever-color=$CLEAR --ringver-color=$VERIFYING --insidewrong-color=$CLEAR --ringwrong-color=$WRONG --inside-color=$BLANK --ring-color=$DEFAULT --line-color=$BLANK --separator-color=$DEFAULT --verif-color=$TEXT --wrong-color=$TEXT --time-color=$TEXT --date-color=$TEXT --layout-color=$TEXT --keyhl-color=$WRONG --bshl-color=$WRONG --ring-width=2 --pass-media-keys --pass-volume-keys --blur 5 --clock --time-str='%H:%M:%S' --date-str='%A, %d/%m/%Y'"

pre_lock

if [[ -e /dev/fd/${XSS_SLEEP_LOCK_FD:--1} ]]; then
    kill_i3lock() {
      pkill -xu $EUID "$@" i3lock
    }

    trap kill_i3lock TERM INT

    i3lock $i3lock_options {XSS_SLEEP_LOCK_FD}<&-

    exec {XSS_SLEEP_LOCK_FD}<&-

    while kill_i3lock -0; do
      sleep 0.50
    done
else
    trap 'kill %%' TERM INT
    i3lock $i3lock_options
    wait
fi

post_lock
