# Nemesis Voice Assistant

**Nemesis** is a fully offline, Linux-based voice assistant designed for ultimate system control — no cloud, no delays, just raw voice power.

> “Good morning, commander. Systems are operational.” 
> — Nemesis, every time you boot up.

---

## Features

- Voice-controlled system commands
- Personalized system greetings
- Battery and power monitoring
- Notification reading out loud
- Offline speech recognition (Vosk)
- Autostarts with `.desktop` launchers

---

## Supported Voice Commands

- `Open terminal`
- `Take screenshot`
- `Increase volume` / `Decrease volume`
- `Mute system` / `Unmute`
- `Turn off Wi-Fi` / `Enable Wi-Fi`
- `Check battery`
- `Say hello`
- `Lock system`
- `Open code`
- `How do you feel?`
- *(Add your own in `voice-shell.py`)*

---

## How to Run

```bash
# 1. Clone the repo
git clone https://github.com/bipulsanjel/nemesis-va.git
cd nemesis-va

# 2. Install Python dependencies
pip install -r requirements.txt

# 3. Download a Vosk speech model (e.g., vosk-model-small-en-us)
#    and place it inside a folder named `model/`

# 4. Run Nemesis
python3 voice-shell.py
