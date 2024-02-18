
#!/bin/bash

# Set the path to your wallpaper
wallpaper_path="Downloads/the file/vagabond-takehiko-inoue-wallpaper-f8caaa3ad89c7da1451d37cc5449be15.jpg"

# Set xcompmgr with options for transparency and shadow
xcompmgr -cC -t.25 -r2.2 -o.25 &

# Set the wallpaper using feh with the --bg-fill option
feh --bg-fill "$wallpaper_path"

# Function to update the root window's name with the current date
update_root_window() {
    keyboard_layout=$(setxkbmap -query | awk '/layout/{print $2}')
    xsetroot -name "$(date) | $(acpi --battery) | $keyboard_layout | ﷽"
}


# Update the root window's name every minute
while :; do
    update_root_window
    sleep 1s
done &

# Launch DWM
exec /usr/local/bin/dwm

