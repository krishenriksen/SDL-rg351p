## How to build
```
  ./configure --prefix=/usr/local --libdir=/usr/local/lib/aarch64-linux-gnu --disable-video-opengl --enable-video-kmsdrm=yes --disable-video-directfb --disable-pulseaudio --disable-esd --disable-video-x11 --disable-video-vivante --disable-video-wayland
  make -j4
  sudo make install
```
