current_brightness=$(cat /home/near/.scripts/redshift-config/brightness)
current_temperature=$(cat /home/near/.scripts/redshift-config/temperature)
current_selected=$(cat /home/near/.scripts/redshift-config/selected)

rofi_command="rofi -theme themes/redshift.rasi"
info="${current_temperature}K & ${current_brightness}"

setTB() {
	redshift -x && redshift -O $temperature -b $brightness
	echo "$brightness" > /home/near/.scripts/redshift-config/brightness
	echo "$temperature" > /home/near/.scripts/redshift-config/temperature
	echo "$selected" > /home/near/.scripts/redshift-config/selected
}


# Options
o1=""
o2=""
o3=""
o4=""
o5=""
o6=""

# Variable passed to rofi
options="$o1\n$o2\n$o3\n$o4\n$o5\n$o6"

chosen="$(echo -e "$options" | $rofi_command -p "$info" -dmenu -selected-row "$current_selected")"
case $chosen in
    $o1)
			temperature=6500
			brightness=1
			selected=0
			setTB
        ;;
    $o2)
			temperature=6000
			brightness=1
			selected=1
			setTB
        ;;
    $o3)
			temperature=5000
			brightness=1
			selected=2
			setTB
        ;;
    $o4)
			temperature=4000
			brightness=1
			selected=3
			setTB
        ;;
    $o5)
			temperature=4000
			brightness=0.8
			selected=4
			setTB
        ;;
    $o6)
			temperature=4000
			brightness=0.5
			selected=5
			setTB
        ;;
esac
