#!/bin/bash

if [ $# -eq 0 ]; then
  echo "Usage: $0 <video1> [video2] ..."
  exit 1
fi

TEMP_WAV="/tmp/ltc_temp.wav"

for INPUT in "$@"; do
  if [ ! -f "$INPUT" ]; then
    echo "File not found: $INPUT"
    continue
  fi

  echo "Processing: $INPUT"

  # 1. Extract first 5 seconds of audio
  /opt/homebrew/bin/ffmpeg -y -i "$INPUT" -map 0:a:0 -ac 1 -ar 48000 -t 5 "$TEMP_WAV" 2>/dev/null

  # 2. Detect LTC timecode
  TIMEcode=$(/opt/homebrew/bin/ltcdump "$TEMP_WAV" | grep -oE '[0-9]{2}:[0-9]{2}:[0-9]{2}:[0-9]{2}' | head -1)

  if [ -z "$TIMEcode" ]; then
    echo "No LTC found in: $INPUT"
    continue
  fi

  echo "Detected LTC: $TIMEcode"

  # 3. Apply timecode, dropping existing tmcd track and audio
  OUTPUT="${INPUT%.*}_tc.${INPUT##*.}"
  /opt/homebrew/bin/ffmpeg -y -i "$INPUT" \
    -map 0:v \
    -map -0:a \
    -c copy \
    -timecode "$TIMEcode" \
    "$OUTPUT"

  echo "Done: $OUTPUT"
  echo ""
done

rm -f "$TEMP_WAV"
