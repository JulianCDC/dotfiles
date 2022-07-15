#!/bin/sh

status=`cat ~/.scripts/energy/status.txt`
sleep_delay=`config_manager --cli get energy suspenddelay`

while true; do
    if [ "$status" = "locked" ]; then
      sleep $sleep_delay
      systemctl suspend
    fi

    sleep 10000
done
