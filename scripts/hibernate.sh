#!/bin/sh

if [ "$1" = "start" ]; then
  touch /tmp/hibernate_timer
  sleep 300

  if [ -f /tmp/hibernate_timer ]; then
      systemctl suspend
  fi
elif [ "$1" = "stop" ]; then
  rm -f /tmp/hibernate_timer
fi
