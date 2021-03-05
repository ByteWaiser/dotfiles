#!/bin/sh

setxkbmap tr &
xsetroot -cursor_name left_ptr &
exec awesome
