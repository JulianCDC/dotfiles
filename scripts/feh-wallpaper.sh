 #!/bin/bash

# get wallpaper from config
wallpaper=`~/.settings/getconfig.sh general_wallpaper`

feh --bg-fill --randomize $wallpaper

while true
do
	feh --bg-fill --randomize $wallpaper
	sleep 600
done
