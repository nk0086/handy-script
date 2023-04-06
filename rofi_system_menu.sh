#!/bin/zsh

menu=(
    "Suspend"
    "Logout"
    "Reboot"
    "Shutdown"
)

script=(
	"systemctl suspend"
	"gnome-session-quit --logout --force"
	"systemctl reboot"
	"systemctl poweroff"
)

if selected="$(for (( i=1; i<=$((${#menu[@]})); i++ )) { echo "${menu[$i]}"; } | rofi -dmenu -i -format i -normal-window)"; then
    eval "${script[$selected+1]}"
fi
