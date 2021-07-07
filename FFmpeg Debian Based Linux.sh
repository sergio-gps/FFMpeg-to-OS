#!/bin/bash
sudo apt-get update -qq
sudo apt-get -y install autoconf automake build-essential cmake git-core libass-dev libfreetype6-dev libsdl2-dev libtool libva-dev libvdpau-dev libvorbis-dev libxcb1-dev libxcb-shm0-dev libxcb-xfixes0-dev pkg-config texinfo wget zlib1g-dev yasm nasm libfdk-aac-dev libmp3lame-dev libopus-dev
mkdir -p ~/ffmpeg_sources ~/bin
cd ~/ffmpeg_sources
#Instalamos la libreria x264
git -C x264 pull 2> /dev/null || git clone --depth 1 https://code.videolan.org/videolan/x264.git
cd x264
PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure --prefix="$HOME/ffmpeg_build" --bindir="$HOME/bin" --enable-static --enable-pic
PATH="$HOME/bin:$PATH" make -j8 && make install
#Instalamos la libreria x265
sudo apt-get install mercurial libnuma-dev
cd ~/ffmpeg_sources
if cd x265 2> /dev/null; then hg pull && hg update && cd ..; else hg clone https://bitbucket.org/multicoreware/x265; fi
cd x265/build/linux
PATH="$HOME/bin:$PATH" cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="$HOME/ffmpeg_build" -DENABLE_SHARED=off ../../source
PATH="$HOME/bin:$PATH" make -j8 && make install
#Instalamos la libreria con VP8 / VP9
cd ~/ffmpeg_sources
git -C libvpx pull 2> /dev/null || git clone --depth 1 https://chromium.googlesource.com/webm/libvpx.git
cd libvpx
PATH="$HOME/bin:$PATH" ./configure --prefix="$HOME/ffmpeg_build" --disable-examples --disable-unit-tests --enable-vp9-highbitdepth --as=yasm
PATH="$HOME/bin:$PATH" make -j8 && make install
#Descargamos ffmpeg y lo compilamos
cd ~/ffmpeg_sources
wget -O ffmpeg-snapshot.tar.bz2 https://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2 && tar xjvf ffmpeg-snapshot.tar.bz2
cd ffmpeg
PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure
  --prefix="$HOME/ffmpeg_build"
  --pkg-config-flags="--static"
  --extra-cflags="-I$HOME/ffmpeg_build/include"
  --extra-ldflags="-L$HOME/ffmpeg_build/lib"
  --extra-libs="-lpthread -lm"
  --bindir="$HOME/bin"
  --enable-gpl
  --enable-libaom
  --enable-libass
  --enable-libfdk-aac
  --enable-libfreetype
  --enable-libmp3lame
  --enable-libopus
  --enable-libvorbis
  --enable-libvpx
  --enable-libx264
  --enable-libx265
  --enable-nonfree
PATH="$HOME/bin:$PATH" make -j8 && make install
hash -r
source ~/.profile