# The theme script to rule them all!

function commentLine() {
	local match=$1
	local how=$2
	local file=$3
	sed -i "s|.*${match}|${how} ${match}|" ${file}
}

function uncommentLine() {
	local match=$1
	local how=$2
	local file=$3
	sed -i "s|.*${how} ${match}|${match}|" ${file}
}

function switchTo() {
	local darkconf=$2
	local lightconf=$3
	local how=$4
	local file=$5
	if [[ $1 == "dark" ]]; then
		commentLine "$lightconf" "$how" $file
		uncommentLine "$darkconf" "$how" $file
	fi
	if [[ $1 == "light" ]]; then
		uncommentLine "$lightconf" "$how" $file
		commentLine "$darkconf" "$how" $file
	fi
}

# gtk theme
function xsettings() {
	local darkconf='Net/ThemeName "Ant-Dracula-Blue"'
	local lightconf='Net/ThemeName "Ant"'
	local file=~/.xsettingsd
	switchTo $1 "$darkconf" "$lightconf" '#' $file
}

function gtk() {
	local darkconf='gtk-application-prefer-dark-theme=true'
	local lightconf='gtk-application-prefer-dark-theme=false'
	local file=~/.config/gtk-3.0/settings.ini
	switchTo $1 "$darkconf" "$lightconf" '#' $file
}

# restart telegram
# function telegram() {
# 	pid=$(pgrep telegram-deskto)
# 	echo $pid
# 	if [[ -n "$pid" ]]; then
# 		kill $pid
# 		telegram-desktop &
# 	fi
# }

# kitty needs to be run with --single-instance option
function kittytheme() {
	if [[ $1 == "dark" ]]; then
		kitty @ set-colors -a -c /home/near/.config/kitty/dracula.conf
	fi
	if [[ $1 == "light" ]]; then
		kitty @ set-colors -a -c /home/near/.config/kitty/kitty-themes/themes/AtomOneLight.conf
	fi
}

# nvr: https://github.com/mhinz/neovim-remote
function vimtheme() {
	if [[ $1 == "dark" ]]; then
		vthm="set bg=dark"
	fi
	if [[ $1 == "light" ]]; then
		vthm="set bg=light"
	fi
	for i in $(nvr --serverlist); do
		nvr --servername $i -c "$vthm" &
	done
}

function vimrc() {
	local darkconf='color dracula'
	local lightconf='color one'
	local file=~/.vimrc
	switchTo $1 "$darkconf" "$lightconf" '"' $file
	local darkconf='set bg=dark'
	local lightconf='set bg=light'
	switchTo $1 "$darkconf" "$lightconf" '"' $file
}

function batconfig() {
	local darkconf='--theme="Dracula"'
	local lightconf='--theme="OneHalfLight"'
	local file=~/.config/bat/config
	switchTo $1 "$darkconf" "$lightconf" '#' $file
}

function kittyconf() {
	local darkconf="include ./dracula.conf"
	local lightconf="include ./kitty-themes/themes/Material.conf"
	local file=~/.config/kitty/kitty.conf
	switchTo $1 "$darkconf" "$lightconf" '#' $file
}


if [[ -n "$1"  &&  $1 == "dark" || $1 == "light" ]];then
  mode="$1"
else
	echo "Usage: $0 [ dark | light ]"
	exit
fi

xsettings $mode
gtk $mode
kittytheme $mode
vimtheme $mode
vimrc $mode
batconfig $mode
kittyconf $mode

# restart daemon
xsettingsd > /dev/null 2>&1 &
