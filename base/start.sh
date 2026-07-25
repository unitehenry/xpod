#!/bin/bash
set -e

Xvfb $DISPLAY -screen 0 $RESOLUTION -ac -nolisten tcp -extension RANDR +extension GLX &

sleep 2

x11vnc -display $DISPLAY \
        -forever \
        -shared \
        -rfbport $VNC_PORT \
        -passwd $VNC_PASSWORD \
        -xkb \
        -noxdamage \
        -repeat \
        &

if [ ! -f /app.sh ]; then
    echo "/app.sh was not mounted to image"
    exit 1
fi

/app.sh

wait
