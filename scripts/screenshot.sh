#!/bin/bash
if pgrep -x slurp > /dev/null; then
    exit 0
fi

grim -g "$(slurp -d)" - | wl-copy
