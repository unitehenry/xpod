FROM docker.io/ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive \
    DISPLAY=:0 \
    QT_X11_NO_MITSHM=1 \
    VNC_PORT=5900 \
    VNC_PASSWORD=vncpass \
    RESOLUTION=1920x1080x24

RUN apt-get update && apt-get install -y --no-install-recommends \
        software-properties-common \
        xvfb \
        x11-apps \
        xauth \
        x11vnc \
    && add-apt-repository ppa:xtradeb/apps -y \
    && apt-get update \
    && apt-get install -y chromium \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

RUN useradd -m -U -s /bin/bash chrome

COPY <<'EOF' /start.sh
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

su -c "chromium --disable-gpu" chrome

wait
EOF

RUN chmod +x /start.sh

EXPOSE 5900

CMD ["/start.sh"]
