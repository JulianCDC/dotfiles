#!/bin/sh

sleep_delay=`config_manager --cli get energy suspenddelay`

sleep $sleep_delay

systemctl suspend
