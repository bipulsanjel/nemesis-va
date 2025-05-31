#!/bin/bash

LOCKFILE="/tmp/nemesis_notify.lock"
COOLDOWN_SECONDS=5
LAST_SPOKEN_FILE="/tmp/nemesis_last_notify"
NOTIFY_FILE="/tmp/nemesis_notification.txt"
WAV_FILE="/tmp/nemesis_notify.wav"
BOOSTED_WAV="/tmp/nemesis_notify_boosted.wav"

# If already playing, just exit
if [ -f "$LOCKFILE" ]; then
    exit 0
fi

# Cooldown logic
NOW=$(date +%s)
LAST=$(cat "$LAST_SPOKEN_FILE" 2>/dev/null || echo 0)
if (( NOW - LAST < COOLDOWN_SECONDS )); then
    exit 0
fi

# Read the text
NOTIFY_TEXT=$(cat "$NOTIFY_FILE" 2>/dev/null | head -n 1)
[ -z "$NOTIFY_TEXT" ] && exit 0

# Set lock and timestamp
touch "$LOCKFILE"
echo "$NOW" > "$LAST_SPOKEN_FILE"

# Convert and BOOST volume
pico2wave -w "$WAV_FILE" "$NOTIFY_TEXT"
sox -v 2.5 "$WAV_FILE" "$BOOSTED_WAV"
aplay "$BOOSTED_WAV"

# Release lock
rm -f "$LOCKFILE"
