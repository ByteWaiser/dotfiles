#!/usr/bin/sh

# Terminate already running bar instances
killall polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar
polybar -c ~/.config/polybar/bsp/config top &
polybar -c ~/.config/polybar/bsp/config bottom &

my_laptop_external_monitor=$(xrandr --query | grep 'DP1')
if [[ $my_laptop_external_monitor = *connected* ]]; then
    polybar -c ~/.config/polybar/bsp/config top_external &
    polybar -c ~/.config/polybar/bsp/config bottom_external &
fi
