 #!/bin/bash

wallpaper=`~/.settings/getconfig.sh wallpapers.general`
slideshow_delay=`~/.settings/getconfig.sh wallpapers.slideshow_delay`

feh --bg-fill --randomize $wallpaper

while true
do
	feh --bg-fill --randomize $wallpaper
	sleep $slideshow_delay
done
