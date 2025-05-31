#!/bin/bash

# Get current hour
HOUR=$(date +"%H")

# Determine time-based greeting
if [ "$HOUR" -lt 12 ]; then
    TIME_OF_DAY="Good morning"
elif [ "$HOUR" -lt 18 ]; then
    TIME_OF_DAY="Good afternoon"
else
    TIME_OF_DAY="Good evening"
fi

# Cool rotating messages
MESSAGES=(
    "All systems online. Nemesis initialized."
    "Uplink secure. Neural cache optimized."
    "Power grid stabilized. Awaiting your commands."
    "Command interface synchronized successfully."
    "Encryption layers verified. Threat matrix calibrated."
    "Core directives loaded. Digital perimeter secure."
    "AI diagnostic: All parameters nominal."
    "Visual subroutines linked. HUD ready."
    "Firewall integrity intact. Sir Boss, you are in control."
    "Autonomous systems running optimal. Nemesis standing by."
)

# Pick a random message
MESSAGE="${MESSAGES[$RANDOM % ${#MESSAGES[@]}]}"

# Full speech message
FINAL="$TIME_OF_DAY, Sir Boss. $MESSAGE"

# Create boosted speech
pico2wave -w /tmp/nemesis_greeting.wav "$FINAL"
sox -v 2.5 /tmp/nemesis_greeting.wav /tmp/nemesis_greeting_boosted.wav
aplay /tmp/nemesis_greeting_boosted.wav
rm /tmp/nemesis_greeting.wav /tmp/nemesis_greeting_boosted.wav

# Wait to avoid overlap
sleep 3

# Start notification reader
~/.config/nemesis/notify-reader.sh &
