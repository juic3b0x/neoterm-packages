NEOTERM_PKG_HOMEPAGE=https://cmus.github.io/
NEOTERM_PKG_DESCRIPTION="Small, fast and powerful console music player"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.10.0"
NEOTERM_PKG_REVISION=7
NEOTERM_PKG_DEPENDS="libandroid-support, libiconv, ncurses, pulseaudio, ffmpeg, libmad, opusfile, libflac, libvorbis"
NEOTERM_PKG_SRCURL=https://github.com/cmus/cmus/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=ff40068574810a7de3990f4f69c9c47ef49e37bd31d298d372e8bcdafb973fff
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	LD=$CC
	export CUE_LIBS=" -lm"
	export CONFIG_OSS=n
}

neoterm_step_configure() {
	./configure prefix=$NEOTERM_PREFIX
}
