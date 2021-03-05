#!/usr/bin/env sh

## Add this to your wm startup file.

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 2; done

# Launch bar1 and bar2

my_dp1=$(xrandr -q | grep -oP '^DP1 \K\w+')
my_hdmi1=$(xrandr -q | grep -oP '^HDMI1 \K\w+')

polybar -c ~/.config/polybar/config.ini main &

if [[ my_dp1=connected ]];
then
    xrandr --output eDP1 --primary --mode 1366x768 --rotate normal --output DP1 --mode 1366x768 --rotate normal --right-of eDP1 &
    polybar -c ~/.config/polybar/config_hdmi.ini main &
fi

if [[ my_hdmi1=connected ]];
then
    xrandr --output eDP1 --primary --mode 1366x768 --rotate normal --output HDMI1 --mode 1366x768 --rotate normal --right-of eDP1 &
    polybar -c ~/.config/polybar/config_hdmi.ini main &
fi
