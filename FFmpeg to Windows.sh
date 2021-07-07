SET LIB=%VSINSTALLDIR%VC\lib\store\amd64;%VSINSTALLDIR%VC\atlmfc\lib\amd64;%UniversalCRTSdkDir%lib\%UCRTVersion%\ucrt\x64;;%UniversalCRTSdkDir%lib\%UCRTVersion%\um\x64;C:\Program Files (x86)\Windows Kits\NETFXSDK\4.6\lib\um\x64;;C:\Program Files (x86)\Windows Kits\NETFXSDK\4.6\Lib\um\x64
SET LIBPATH=%VSINSTALLDIR%VC\atlmfc\lib\amd64;%VSINSTALLDIR%VC\lib\amd64;
SET INCLUDE=%VSINSTALLDIR%VC\include;%VSINSTALLDIR%VC\atlmfc\include;%UniversalCRTSdkDir%Include\%UCRTVersion%\ucrt;%UniversalCRTSdkDir%Include\%UCRTVersion%\um;%UniversalCRTSdkDir%Include\%UCRTVersion%\shared;%UniversalCRTSdkDir%Include\%UCRTVersion%\winrt;C:\Program Files (x86)\Windows Kits\NETFXSDK\4.6\Include\um;

./configure   

PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure \
  --prefix="$HOME/ffmpeg_build" \
  --toolchain=msvc \
  --arch=amd64 \
  --enable-x86asm \
  --pkg-config-flags="--static" \
  --extra-cflags="-I$HOME/ffmpeg_build/include" \
  --extra-ldflags="-L$HOME/ffmpeg_build/lib" \
  --extra-libs="-lpthread -lm" \
  --bindir="$HOME/bin" \
  --enable-gpl \
  --enable-amf \
  --enable-libass \
  --enable-libfdk-aac \
  --enable-libfreetype \
  --enable-libmp3lame \
  --enable-libopus \
  --enable-libvorbis \
  --enable-libvpx \
  --enable-libx264 \
  --enable-libx265 \
  --enable-nonfree
  --enable-libaom \