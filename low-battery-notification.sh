#!/usr/bin/env bash
acpi -b | awk -F'[,:%]' '{print $2, $3}' | {
	read -r status capacity

	if [ "$status" = Discharging -a "$capacity" -lt 15 ]; then
		dunstify -r 12 -u critical "Battery low."
	fi
}
