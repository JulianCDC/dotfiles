#!/bin/sh

update_number=`yay -Qu | wc -l`

echo $update_number > ~/.scripts/updates-checker/updates.txt
