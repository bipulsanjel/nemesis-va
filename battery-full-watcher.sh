#!/bin/bash

WATCH_PATH="/sys/class/power_supply/BAT1/capacity"
CHARGE_STATUS_PATH="/sys/class/power_supply/BAT1/status"
LAST_STATE=""

while true; do
    CHARGE=$(cat "$WATCH_PATH" 2>/dev/null)
    STATUS=$(cat "$CHARGE_STATUS_PATH" 2>/dev/null)

    if [[ "$CHARGE" -eq 100 && "$STATUS" == "Full" && "$LAST_STATE" != "FULLY_CHARGED" ]]; then
        TEXT="Sir Boss, battery is now fully charged. Suggest unplugging the power source."
        pico2wave -w /tmp/nemesis_battery_full.wav "$TEXT"
        sox -v 2.5 /tmp/nemesis_battery_full.wav /tmp/nemesis_battery_full_boosted.wav
        aplay /tmp/nemesis_battery_full_boosted.wav
        rm /tmp/nemesis_battery_full.wav /tmp/nemesis_battery_full_boosted.wav
        LAST_STATE="FULLY_CHARGED"
    elif [[ "$CHARGE" -lt 100 ]]; then
        LAST_STATE=""
    fi

    sleep 30
done
