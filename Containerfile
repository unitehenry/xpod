FROM docker.io/ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive \
    DISPLAY=:0 \
    QT_X11_NO_MITSHM=1 \
    VNC_PORT=5900 \
    VNC_PASSWORD=vncpass \
    RESOLUTION=1920x1080x24

# Install X11 utilities + x11vnc
RUN apt-get update && apt-get install -y --no-install-recommends \
    xvfb \
    x11-apps \
    xauth \
    x11vnc \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# Create a simple startup script
COPY <<'EOF' /start.sh
#!/bin/bash
set -e

echo "Starting Xvfb (virtual display)..."
Xvfb $DISPLAY -screen 0 $RESOLUTION -ac -nolisten tcp -extension RANDR +extension GLX &

echo "Waiting for Xvfb to start..."
sleep 2

echo "Starting x11vnc..."

x11vnc -display $DISPLAY \
        -forever \
        -shared \
        -rfbport $VNC_PORT \
        -passwd $VNC_PASSWORD \
        -xkb \
        -noxdamage \
        -repeat \
        &

echo "Starting test app (xclock)..."
xclock &

echo "VNC server ready on port $VNC_PORT"
wait
EOF

RUN chmod +x /start.sh

EXPOSE 5900

CMD ["/start.sh"]
