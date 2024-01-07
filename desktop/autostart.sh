
#!/bin/bash

# Set the path to your wallpaper
wallpaper_path="Downloads/the file/vagabond-takehiko-inoue-wallpaper-f8caaa3ad89c7da1451d37cc5449be15.jpg"

# Set xcompmgr with options for transparency and shadow
xcompmgr -cC -t.25 -r2.2 -o.25 &

# Set the wallpaper using feh with the --bg-fill option
feh --bg-fill "$wallpaper_path"

# Function to update the root window's name with the current date
update_root_window() {
    xsetroot -name "$(date)"
}

# Update the root window's name every minute
while :; do
    update_root_window
    sleep 1m
done &

# Launch DWM
exec /usr/local/bin/dwm

