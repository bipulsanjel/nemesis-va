#!/bin/bash

dbus-monitor "interface='org.freedesktop.Notifications'" |
while read -r line; do
    if echo "$line" | grep -q "member=Notify"; then
        # Wait and grab the next few lines
        read -r _ # app_name
        read -r _ # replaces_id
        read -r _ # app_icon
        read -r summary
        read -r body_line
        
        body=$(echo "$body_line" | sed -n 's/.*string "\(.*\)"/\1/p')
        
        if [ -n "$body" ]; then
            echo "$body" > /tmp/nemesis_notification.txt
            ~/.config/nemesis/notify-reader.sh &
        fi
    fi
done
