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
        x11vnc

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 5900

CMD ["/start.sh"]
