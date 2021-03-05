#!/usr/bin/env bash

s=$(playerctl status)
if [[ $s!="Stopped" ]];
then
    echo $(playerctl metadata -f '{{albumArtist}} - {{title}}')
fi
