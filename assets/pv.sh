#!/bin/bash

target_comes() {
    while true; do
        originalPOS=$(xdotool getmouselocation --shell | grep 'X=' | cut -d'=' -f2)
        sleep 3
        currentPOS=$(xdotool getmouselocation --shell | grep 'X=' | cut -d'=' -f2)
        if [ "$originalPOS" != "$currentPOS" ]; then
            break
        else
            xdotool key Caps_Lock
        fi
    done
}

# Set the path to the video file
video_file="/tmp/pv/pv.mp4"

# Play the video using the default video player
xdg-open "$video_file" &

target_comes

# Wait for the video player to start playing
sleep 1

# Minimize all windows to show the video
xdotool key --clearmodifiers Super+d

# Wait for the video to finish playing
while pgrep -x "xdg-open" > /dev/null; do
    sleep 1
done

# Turn off Caps Lock if it is left on
if [ "$(xset -q | grep 'Caps Lock:' | awk '{print $4}')" == "on" ]; then
    xdotool key Caps_Lock
fi

# Empty temporary folder
rm -rf "/tmp/pv"/*

# Clear bash history
# history -c && history -w

# Empty the trash
# trash-empty
