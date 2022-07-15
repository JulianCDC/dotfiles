 #!/bin/bash

wallpapers=`config_manager --cli get appearance desktopwallpapers`
slideshow_delay=`config_manager --cli get appearance desktopslideshowinterval`

while true
do
	feh --bg-fill --randomize $wallpapers
	sleep $slideshow_delay
done
