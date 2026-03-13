#!/bin/bash

echo "[+] Updating system..."
sudo apt update

echo "[+] Installing dependencies..."
sudo apt install -y ffmpeg git cmake build-essential

echo "[+] Installing whisper.cpp..."
git clone https://github.com/ggerganov/whisper.cpp.git
cd whisper.cpp || exit
make

echo "[+] Downloading Whisper model..."
bash models/download-ggml-model.sh base.en

echo "[+] Optional: Installing translate-shell..."
sudo apt install -y translate-shell

echo "[✓] Installation complete!"
