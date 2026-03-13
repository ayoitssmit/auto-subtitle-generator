# Auto Subtitle Generator

Auto Subtitle Generator is a robust, command-line utility built entirely with shell scripts to automate the extraction and transcription of audio from video files. By leveraging the efficient whisper.cpp framework, it provides highly accurate offline speech-to-text generation and produces standard SubRip Subtitle (.srt) files natively. Additionally, it offers optional subtitle translation capabilities to bridge language gaps easily.

## Features
* **Automated Audio Extraction:** Effortlessly extracts audio tracks from any user-provided video file using FFmpeg, automatically dealing with various formats.
* **Offline Speech Recognition:** Integrates with the optimized whisper.cpp engine (running the ggml-base.en model) to perform fast, CPU-efficient transcription without requiring an internet connection or external APIs.
* **Ready-To-Use Subtitles:** Directly converts raw transcripts into correctly timed and formatted standard .srt files, ready to be embedded or loaded into video players.
* **Integrated Translation Engine:** Employs translate-shell for automated, optional conversion of generated English subtitles to any specified target language, streamlining localization pipelines.

## Prerequisites
Before running the installation script, ensure you are on a compatible Linux environment or can run bash scripts (e.g. via WSL, macOS). The installation script will attempt to install the following dependencies via standard package managers (e.g., Ubuntu/Debian):
* FFmpeg
* Git
* CMake
* Build-essential

## Installation
An automatic installation script is provided to set up dependencies, compile whisper.cpp, and download the needed acoustic models.

```bash
chmod +x install.sh
./install.sh
```

## Usage
Run the main script with the target video file as the primary argument. You can also specify an optional language code for translation.

```bash
chmod +x app.sh
./app.sh input_video.mp4 [target_language_code]
```

For example, to transcribe and translate a lecture to Spanish:
```bash
./app.sh lecture.mp4 es
```
