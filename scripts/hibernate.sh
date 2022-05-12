#!/bin/sh

sleep_delay=`getconfig system.sleep_delay`

sleep $sleep_delay

systemctl suspend-then-hibernate
