NEOTERM_PKG_HOMEPAGE=https://github.com/vgmstream/vgmstream
NEOTERM_PKG_DESCRIPTION="A library for playback of various streamed audio formats used in video games"
NEOTERM_PKG_LICENSE="ISC"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1896"
NEOTERM_PKG_SRCURL=https://github.com/vgmstream/vgmstream/archive/refs/tags/r${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=3e4de85e3775b41b102fbd794cd40130f5e9561ecb960f6f2b690d8084a7c22a
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP='\d+'
NEOTERM_PKG_DEPENDS="ffmpeg, libao, libjansson, libspeex, libvorbis, mpg123"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DUSE_G719=OFF
-DUSE_ATRAC9=OFF
-DUSE_CELT=OFF
-DBUILD_AUDACIOUS=OFF
"
