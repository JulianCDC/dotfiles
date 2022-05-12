 #!/bin/bash

wallpaper=`getconfig wallpapers.general`
slideshow_delay=`getconfig wallpapers.slideshow_delay`

feh --bg-fill --randomize $wallpaper

while true
do
	feh --bg-fill --randomize $wallpaper
	sleep $slideshow_delay
done
