#!/bin/sh

# is_inhibited() {
#   inhibitors=`systemd-inhibit | grep block | wc -l`

#   if [ "$inhibitors" -gt 0 ]; then
#     echo "yes"
#   else
#     echo "no"
#   fi
# }

get_state() {
  state=`cat ~/.scripts/screensaver/state`

  if [ $state == "on" ]; then
      # if [ `is_inhibited` == "yes" ]; then
          # echo ""
      # else
      echo ""
      # fi
  else
      echo "%{F#707880}%{F-}"
  fi
}

get_state

inotifywait -m -q -e modify ~/.scripts/screensaver/state | while read -r; do
  get_state
done
