#!/bin/bash

beep='paplay /usr/share/sounds/gnome/default/alerts/glass.ogg'

battery_level=`acpi -b | grep -P -o '[0-9]+(?=%)'`
if [ $battery_level -le 10 ]; then
    notify-send "Battery low" "Battery level is ${battery_level}%!"
    eval $beep
fi
