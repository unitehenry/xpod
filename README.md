# XPod

A minimal container build of X11 with VNC support.

## Build

This project uses `podman` to build container images, but the `Containerfile` is interoperable with Docker as well. If you have `podman`, the following build scripts are available to use.

```bash
scripts/build
```

This `build` script will build the xpod base image and apps (currently only chromium). The `xpod-base` image is a minimal setup of X11, the VNC server, and a X Virtual Framebuffer.

### App Support

If you'd like to run another app on top of the `xpod-base` image, the only requirement is that you mount a `/app.sh` to the root of the image.

```Dockerfile
COPY app.sh /app.sh
RUN chmod +x /app.sh
```

## Environment Variables

|Variable|Default|Description|
|:-:|:-:|:-:|
|`VNC_PASSWORD`|`vncpass`|Password to use for connecting via VNC|


## Chromium Profiles

The `xpod-chromium` image accepts an optional volume mount for porting chromium profiles after use.

```bash
podman run -v ./chromium-lib:/var/lib/chromium xpod-chromium
```

## Additional Resources

- [neko](https://github.com/m1k1o/neko)
