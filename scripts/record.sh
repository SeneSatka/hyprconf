#!/bin/bash

OUTPUT_DIR="$HOME/Videos"
mkdir -p "$OUTPUT_DIR"

PIDFILE="/tmp/wf-recorder-pid"
FILE="$OUTPUT_DIR/recording-$(date +'%Y-%m-%d_%H-%M-%S').mp4"

if [ -f "$PIDFILE" ]; then
    PID=$(cat "$PIDFILE")
    if kill -0 $PID 2>/dev/null; then
        kill $PID
        rm "$PIDFILE"
        notify-send "Screen Recorder" "Recording stopped."
        exit 0
    else
        rm "$PIDFILE"
    fi
fi

GEOM=$(slurp)
if [ -z "$GEOM" ]; then
    notify-send "Screen Recorder" "No screen area selected, exiting."
    exit 1
fi

wf-recorder -g "$GEOM" -f "$FILE" &
echo $! > "$PIDFILE"

notify-send "Screen Recorder" "Recording started: $FILE"

