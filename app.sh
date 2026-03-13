#!/bin/bash

# ===============================
# Auto Subtitle Generator
# ===============================

if [ $# -lt 1 ]; then
  echo "Usage: ./app.sh <video-file> [target-language]"
  echo "Example: ./app.sh lecture.mp4 hi"
  exit 1
fi

VIDEO="$1"
LANG="${2:-en}"

# Validate input file
if [ ! -f "$VIDEO" ]; then
  echo "[ERROR] Video file not found!"
  exit 1
fi

mkdir -p output

AUDIO="output/audio.wav"
SUB="output/subtitles.srt"

echo "[+] Video file: $VIDEO"
echo "[+] Target language: $LANG"

# Step 1: Extract audio
echo "[+] Extracting audio from video..."
ffmpeg -loglevel error -i "$VIDEO" -ar 16000 -ac 1 "$AUDIO" -y

if [ $? -ne 0 ]; then
  echo "[ERROR] Audio extraction failed"
  exit 1
fi

# Step 2: Speech-to-text
echo "[+] Running speech-to-text engine..."
./whisper.cpp/main \
  -m whisper.cpp/models/ggml-base.en.bin \
  -f "$AUDIO" \
  -otxt

TRANSCRIPT="${AUDIO}.txt"

if [ ! -f "$TRANSCRIPT" ]; then
  echo "[ERROR] Transcription failed"
  exit 1
fi

# Step 3: Convert transcript to SRT
echo "[+] Generating subtitles..."
awk '{
  printf "%d\n00:00:%02d,000 --> 00:00:%02d,000\n%s\n\n", NR, (NR-1)*3, NR*3, $0
}' "$TRANSCRIPT" > "$SUB"

# Step 4: Optional translation
if [ "$LANG" != "en" ]; then
  echo "[+] Translating subtitles to $LANG..."
  trans -b :$LANG file:"$SUB" > output/subtitles_translated.srt
fi

echo "[✓] Subtitle generation completed!"
echo "[✓] Output file: $SUB"
