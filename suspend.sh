#!/bin/bash
#

if [[ ( -n "$1"   &&  -n "$2" ) ]]
then
	if [ "$2" == "m" ]
	then
		echo "MIN"
		echo "i3exit suspend" | at now + "$1" min
	elif [ "$2" == "h" ]
	then
		echo "HOUR"
		echo "i3exit suspend" | at now + "$1" hour
	else
		echo "suspend.sh {number} {h: hour - m: minute}"
	fi
else
	echo "suspend.sh {number} {h: hour - m: minute}"
fi

