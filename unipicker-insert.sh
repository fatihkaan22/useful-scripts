#!/bin/bash
xdotool type --clearmodifiers --window $(xdotool getactivewindow) $(unipicker --command "rofi -dmenu -theme /home/near/.config/rofi/launchers/general.rasi -lines 8" )
