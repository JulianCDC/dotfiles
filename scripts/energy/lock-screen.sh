#!/bin/sh

# random_image_path=`find ~/.cache/lockscreen -type f | shuf -n 1`

lockscreen_folder=`~/.settings/getconfig.sh wallpapers.lockscreen_converted`
slideshow_interval=`~/.settings/getconfig.sh wallpapers.lockscreen_slideshow_delay`

echo "locked" > ~/.scripts/energy/status.txt

BLANK='#00000000'
CLEAR='#ffffff22'
DEFAULT='#FFFFFFcc'
TEXT='#FFFFFFee'
WRONG='#136ED7bb'
VERIFYING='#FFFFFFbb'

i3lock --nofork \
-i $lockscreen_folder \
--slideshow-interval=$slideshow_interval \
--slideshow-random-selection \
--fill \
--insidever-color=$CLEAR     \
--ringver-color=$VERIFYING   \
\
--insidewrong-color=$CLEAR   \
--ringwrong-color=$WRONG     \
\
--inside-color=$BLANK        \
--ring-color=$DEFAULT        \
--line-color=$BLANK          \
--separator-color=$DEFAULT   \
\
--verif-color=$TEXT          \
--wrong-color=$TEXT          \
--time-color=$TEXT           \
--date-color=$TEXT           \
--layout-color=$TEXT         \
--keyhl-color=$WRONG         \
--bshl-color=$WRONG          \
--ring-width=2               \
--pass-media-keys            \
--pass-volume-keys           \
--blur 5                     \
--clock                      \
--time-str="%H:%M:%S"        \
--date-str="%A, %d/%m/%Y"; echo "unlocked" > ~/.scripts/energy/status.txt
