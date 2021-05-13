# The theme script to rule them all!

# gtk theme
function xsettings() {
	if [[ $1 == "dark" ]]; then
		sed -i 's/.*Net\/ThemeName "Ant"/# Net\/ThemeName "Ant"/' ~/.xsettingsd
		sed -i 's/.*# Net\/ThemeName "Ant-Dracula-Blue"/Net\/ThemeName "Ant-Dracula-Blue"/' ~/.xsettingsd 
	fi
	if [[ $1 == "light" ]]; then
		sed -i 's/.*# Net\/ThemeName "Ant"/Net\/ThemeName "Ant"/' ~/.xsettingsd
		sed -i 's/.*Net\/ThemeName "Ant-Dracula-Blue"/# Net\/ThemeName "Ant-Dracula-Blue"/' ~/.xsettingsd
	fi
}

function gtk() {
	if [[ $1 == "dark" ]]; then
		sed -i 's/gtk-application-prefer-dark-theme=false/gtk-application-prefer-dark-theme=true/' ~/.config/gtk-3.0/settings.ini
	fi
	if [[ $1 == "light" ]]; then
		sed -i 's/gtk-application-prefer-dark-theme=true/gtk-application-prefer-dark-theme=false/' ~/.config/gtk-3.0/settings.ini
	fi
}

function telegram() {
	pid=$(pgrep telegram-deskto)
	echo $pid
	if [[ -n "$pid" ]]; then
		kill $pid
		telegram-desktop &
	fi
}

# kitty needs to be run with --single-instance option
function kittytheme() {
	if [[ $1 == "dark" ]]; then
		kitty @ set-colors -a -c /home/near/.config/kitty/theme.conf
	fi
	if [[ $1 == "light" ]]; then
		kitty @ set-colors -a -c /home/near/.config/kitty/kitty-themes/themes/AtomOneLight.conf
	fi
}

# nvr: https://github.com/mhinz/neovim-remote
function vimtheme() {
	vthm=""
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

# reload
# telegram

# restart daemon
xsettingsd > /dev/null 2>&1 &
