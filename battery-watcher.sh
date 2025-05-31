#!/bin/bash

ALERTED=false

while true; do
    BATTERY_LEVEL=$(cat /sys/class/power_supply/BAT1/capacity 2>/dev/null)
    STATUS=$(cat /sys/class/power_supply/BAT1/status 2>/dev/null)

    if [[ "$BATTERY_LEVEL" -lt 20 && "$STATUS" == "Discharging" ]]; then
        if [[ "$ALERTED" == false ]]; then
            TEXT="Sir Boss, battery level is critically low. Immediate power source is advised to prevent shutdown."
            pico2wave -w /tmp/nemesis_notify.wav "$TEXT"
            sox -v 2.0 /tmp/nemesis_notify.wav /tmp/nemesis_notify_boosted.wav
            aplay /tmp/nemesis_notify_boosted.wav

            ALERTED=true
        fi
    else
        ALERTED=false
    fi

    sleep 60
done
