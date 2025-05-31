#!/bin/bash

LAST_STATE=""

while true; do
    CURRENT_STATE=$(cat /sys/class/power_supply/ACAD/online 2>/dev/null)

    if [[ "$CURRENT_STATE" != "$LAST_STATE" ]]; then
        # Avoid speaking on the very first run
        if [[ "$LAST_STATE" != "" ]]; then
            if [[ "$CURRENT_STATE" == "1" ]]; then
                TEXT="Sir Boss, AC power has been restored. Systems stabilizing."
            else
                TEXT="Sir Boss, AC power disconnected. Switching to internal reserves."
            fi

            # Speak with volume boost using sox
            pico2wave -w /tmp/nemesis_notify.wav "$TEXT"
            sox -v 2.5 /tmp/nemesis_notify.wav /tmp/nemesis_notify_boosted.wav
            aplay /tmp/nemesis_notify_boosted.wav
        fi

        LAST_STATE="$CURRENT_STATE"
    fi

    sleep 3
done
