#!/bin/zsh

# Get the current workspace
current_workspace=$(wmctrl -d | awk '/\*/ {print $1}')

# Get the window IDs of the current workspace
window_ids=($(wmctrl -l | awk -v workspace="$current_workspace" '$2 == workspace {print $1}'))

# Get the active monitor and its size
active_monitor_info=$(xrandr --current | grep -w "connected" | awk '{if ($3 == "primary") print $0; else if (NF == 3) print $0}' | head -n 1)
screen_width=$(echo $active_monitor_info | awk -F'[ +x]' '{print $4}')
screen_height=$(echo $active_monitor_info | awk -F'[ +x]' '{print $5}')
screen_x_offset=$(echo $active_monitor_info | awk -F'[ +x]' '{print $6}')
screen_y_offset=$(echo $active_monitor_info | awk -F'[ +x]' '{print $7}')

# Get the number of windows
num_windows=${#window_ids[@]}

for i in "${!window_ids[@]}"; do
    x=$((i * screen_width / num_windows + screen_x_offset))
    width=$((screen_width / num_windows))
    wmctrl -i -r "${window_ids[$i]}" -e "0,$x,$screen_y_offset,$width,$screen_height"
done
