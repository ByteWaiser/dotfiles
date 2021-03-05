#!/usr/bin/sh

# Launch bar
polybar workspaces &
polybar music &
polybar memory &
polybar date &
polybar time &
polybar volume &
polybar battery &

my_laptop_external_monitor=$(xrandr --query | grep -oP '^DP1 \K\w+')
if [[ $my_laptop_external_monitor = connected ]]; 
then
    xrandr --output eDP1 --primary --mode 1366x768 --rotate normal --output DP1 --mode 1366x768 --rotate normal --left-of eDP1 &
    polybar workspaces_external &
    polybar music_external &
    polybar memory_external &
    polybar date_external &
    polybar time_external &
    polybar volume_external &
    polybar battery_external &
fi
