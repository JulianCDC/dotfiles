#!/bin/sh

while true; do
  sleep 300

  update_number=`yay -Qu | wc -l`

  echo $update_number > ~/.scripts/updates-checker/updates.txt
done
