#!/usr/bin/env bash

TARGET_DIR="$HOME/Videos/Recordings"
mkdir -p "$TARGET_DIR"
OUTPUT_FILE="$TARGET_DIR/$(date +%Y-%m-%d-%H-%M-%S).mp4"

# Check if wf-recorder is already active
if pgrep -x wf-recorder > /dev/null; then
    # wf-recorder needs a SIGINT signal (-2) to close its container cleanly
    pkill -2 -x "wf-recorder"
    notify-send "Recording Saved" "Video stored in: $TARGET_DIR"
    exit 0
fi

GEOM=$(slurp)

if [ -n "$GEOM" ]; then
    notify-send "Recording" "Recording area: $GEOM"
    # -g sets the geometry, -f sets the target file
    wf-recorder -g "$GEOM" -f "$OUTPUT_FILE"
fi
