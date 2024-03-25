NEOTERM_PKG_HOMEPAGE=https://github.com/libsdl-org/SDL_mixer
NEOTERM_PKG_DESCRIPTION="A simple multi-channel audio mixer"
NEOTERM_PKG_LICENSE="ZLIB"
NEOTERM_PKG_LICENSE_FILE="LICENSE.txt"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.8.0"
NEOTERM_PKG_SRCURL=https://github.com/libsdl-org/SDL_mixer/releases/download/release-${NEOTERM_PKG_VERSION}/SDL2_mixer-${NEOTERM_PKG_VERSION}.tar.gz 
NEOTERM_PKG_SHA256=1cfb34c87b26dbdbc7afd68c4f545c0116ab5f90bbfecc5aebe2a9cb4bb31549
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_SED_REGEXP='s/.*-//'
NEOTERM_PKG_DEPENDS="fluidsynth, libflac, libmodplug, libvorbis, mpg123, opusfile, sdl2"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-music-mod-modplug-shared
--disable-music-midi-fluidsynth-shared
--disable-music-ogg-stb
--enable-music-ogg-vorbis
--disable-music-ogg-vorbis-shared
--disable-music-flac-drflac
--enable-music-flac-libflac
--disable-music-flac-libflac-shared
--disable-music-mp3-drmp3
--enable-music-mp3-mpg123
--disable-music-mp3-mpg123-shared
--disable-music-opus-shared
"
