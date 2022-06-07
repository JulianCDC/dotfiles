#!/bin/sh

if [ "$EUID" -ne 0 ]; then
    echo "This utility must be run as root"
    exit
fi

echo "Installing yay"
