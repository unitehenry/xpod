#!/bin/bash
set -e

socat TCP-LISTEN:9222,bind=0.0.0.0,reuseaddr,fork TCP:127.0.0.1:9223 &

mkdir -p /var/lib/chromium
chmod -R 777 /var/lib/chromium
rm -rf /var/lib/chromium/profile/Singleton*

CHROMIUM_WIDTH=${RESOLUTION%%x*}
CHROMIUM_HEIGHT=${RESOLUTION#*x}; CHROMIUM_HEIGHT=${CHROMIUM_HEIGHT%%x*}

su -c "chromium --disable-gpu --start-maximized --window-size=${CHROMIUM_WIDTH},${CHROMIUM_HEIGHT} --force-device-scale-factor=1 --remote-debugging-port=9223 --user-data-dir=/var/lib/chromium/profile" chrome
