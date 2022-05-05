#!/bin/sh

config_value=`awk -F "=" '/'"$1"'/ {print $2}' ~/.settings/config.ini | sed 's/\r$//'`

# expand variables in config_value
eval echo $config_value
