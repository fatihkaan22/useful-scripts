#!/bin/bash

text=$(xsel -o)
textLenght=${#text}
secondsToWait=$(($textLenght/10+2))

msToWait=$(($secondsToWait*1000))

notify-send -t "$msToWait" -a MyTranslator "$(trans -identify -b :tr "$text")"
