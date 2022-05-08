 #!/bin/bash

# get wallpaper from config
wallpaper=`~/.settings/getconfig.sh wallpapers.general`

feh --bg-fill --randomize $wallpaper

while true
do
	feh --bg-fill --randomize $wallpaper
	sleep 600
done
