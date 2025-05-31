import os
import queue
import sounddevice as sd
import vosk
import sys
import json
import subprocess

# Set absolute model path
BASE_DIR = os.path.abspath(os.path.dirname(__file__))
MODEL_PATH = os.path.join(BASE_DIR, "model")

# Check if model exists
if not os.path.exists(MODEL_PATH):
    print(f"Model not found at: {MODEL_PATH}")
    sys.exit(1)

# Load model
model = vosk.Model(MODEL_PATH)
samplerate = 16000
q = queue.Queue()

def callback(indata, frames, time, status):
    if status:
        print("Error!", status, file=sys.stderr)
    q.put(bytes(indata))

def speak(text):
    os.system(f'pico2wave -w {BASE_DIR}/temp.wav "{text}" && aplay {BASE_DIR}/temp.wav && rm {BASE_DIR}/temp.wav')

def execute_command(command):
    command = command.lower()
    print(f"Heard command: {command}")

    if "open terminal" in command:
        subprocess.Popen(["gnome-terminal"])
        speak("Terminal deployed, Commander.")

    elif "open browser" in command:
        subprocess.Popen(["firefox"])
        speak("Engaging the web engines.")

    elif "say hello" in command:
        speak("Hello. Nemesis online and operational.")

    elif "take screenshot" in command:
        subprocess.Popen(["gnome-screenshot"])
        speak("Screenshot captured.")

    elif "increase volume" in command:
        subprocess.run(["pactl", "set-sink-volume", "@DEFAULT_SINK@", "+10%"])
        speak("Volume boosted. Enjoy responsibly.")

    elif "decrease volume" in command:
        subprocess.run(["pactl", "set-sink-volume", "@DEFAULT_SINK@", "-10%"])
        speak("Volume decreased. Peace and quiet.")

    elif "mute" in command:
        subprocess.run(["pactl", "set-sink-mute", "@DEFAULT_SINK@", "1"])
        speak("System muted. Ninja mode activated.")

    elif "unmute" in command:
        subprocess.run(["pactl", "set-sink-mute", "@DEFAULT_SINK@", "0"])
        speak("Sound restored. Welcome back.")

    elif "turn off wi-fi" in command:
        subprocess.run(["nmcli", "radio", "wifi", "off"])
        speak("Wi-Fi disabled. Going off the grid.")

    elif "enable wi-fi" in command:
        subprocess.run(["nmcli", "radio", "wifi", "on"])
        speak("Wi-Fi enabled. Back online.")

    elif "check battery" in command:
        result = subprocess.run(["acpi"], stdout=subprocess.PIPE, text=True)
        speak(f"Battery status: {result.stdout.strip()}")

    elif "how do you feel" in command:
        speak("Like a beast trapped in silicon, ready to serve.")

    elif "lock system" in command:
        speak("Locking system. Stay safe, boss.")
        subprocess.Popen(["gnome-screensaver-command", "-l"])

    elif "open code" in command:
        subprocess.Popen(["code"])
        speak("Launching the code forge.")

    elif "shutdown" in command:
        speak("Shutting down. Nemesis out.")
        sys.exit(0)

    elif "nemesis" in command:
        speak("Standing by. Orders?")

    else:
        print("Unknown command.")
        # No speaking if not recognized

def main():
    # speak("Nemesis online. Voice shell active.")
    with sd.RawInputStream(samplerate=samplerate, blocksize=8000, dtype='int16',
                           channels=1, callback=callback):
        rec = vosk.KaldiRecognizer(model, samplerate)
        print("Nemesis is listening...")

        while True:
            data = q.get()
            if rec.AcceptWaveform(data):
                result = json.loads(rec.Result())
                text = result.get("text", "").strip()
                print(f"Recognized: '{text}'")

                # Ignore if it's empty or less than 1 word
                if len(text.split()) >= 1:
                    execute_command(text)

if __name__ == "__main__":
    main()
