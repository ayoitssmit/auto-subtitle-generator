#!/bin/bash
# =========================================
# Auto Subtitle Generator (Improved Sync)
# =========================================

if [ $# -lt 1 ]; then
  echo "Usage: ./app.sh <video-file>"
  exit 1
fi

VIDEO="$1"
OUTPUT_DIR="output"
AUDIO="$OUTPUT_DIR/audio.wav"
SUBTITLE_PREFIX="$OUTPUT_DIR/subtitles"
MODEL="whisper.cpp/models/ggml-base.en.bin"
WHISPER_BIN="whisper.cpp/build/bin/whisper-cli"

# ---------- Validation ----------
if [ ! -f "$VIDEO" ]; then
  echo "[ERROR] Video file not found!"
  exit 1
fi

if [ ! -f "$WHISPER_BIN" ]; then
  echo "[ERROR] whisper-cli not found. Run install.sh first."
  exit 1
fi

if [ ! -f "$MODEL" ]; then
  echo "[ERROR] Whisper model not found."
  exit 1
fi

mkdir -p "$OUTPUT_DIR"

echo "[+] Video file: $VIDEO"

# ---------- Step 1: Extract Audio ----------
echo "[+] Extracting audio..."
ffmpeg -loglevel error -i "$VIDEO" -ar 16000 -ac 1 "$AUDIO" -y
if [ $? -ne 0 ]; then
  echo "[ERROR] Audio extraction failed"
  exit 1
fi

# ---------- Step 2: Generate Subtitles (Accurate Timing) ----------
echo "[+] Generating subtitles with improved synchronization..."
"$WHISPER_BIN" \
  -m "$MODEL" \
  -f "$AUDIO" \
  -osrt \
  -of "$SUBTITLE_PREFIX" \
  --offset-t 0.5 \
  --max-len 42 \
  --split-on-word

if [ $? -ne 0 ]; then
  echo "[ERROR] Transcription failed"
  exit 1
fi

echo "[✓] Subtitles generated successfully!"
echo "[✓] Output file: output/subtitles.srt"
