#!/usr/bin/env sh

my_dp1=$(xrandr -q | grep -oP '^DP1 \K\w+')
my_hdmi1=$(xrandr -q | grep -oP '^HDMI1 \K\w+')

if [[ my_dp1=connected ]];
then
    xrandr --output eDP1 --primary --mode 1366x768 --rotate normal --output DP1 --mode 1366x768 --rotate normal --right-of eDP1 &
fi

if [[ my_hdmi1=connected ]];
then
    xrandr --output eDP1 --primary --mode 1366x768 --rotate normal --output HDMI1 --mode 1366x768 --rotate normal --right-of eDP1 &
fi
