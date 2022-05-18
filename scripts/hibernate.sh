#!/bin/sh

sleep_delay=`~/.settings/getconfig.sh system.sleep_delay`

sleep $sleep_delay

systemctl suspend
