# Nemesis Voice Assistant 

Nemesis is a Linux-based offline voice assistant that performs system-level actions using natural voice commands.

# Features

- Voice-controlled terminal commands
- Personalized system greetings
- Battery and power monitoring
- Desktop notification reader
- Offline speech recognition (using Vosk)
- Auto-launch on startup with `.desktop` files

# Voice Commands

- "Open terminal"
- "Take screenshot"
- "Increase volume"
- "Check battery"
- "Say hello"
- "Turn off Wi-Fi"
- "Lock system"
- More...

#How to Run

* Clone the repo:
```bash```
git clone https://github.com/yourusername/nemesis-va.git
cd nemesis-va

# Install dependencies
pip install -r requirements.txt

# Download the Vosk model and place it in a model/ folder

# Run the assistant
python3 voice-shell.py
 
