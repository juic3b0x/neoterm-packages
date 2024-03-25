NEOTERM_PKG_HOMEPAGE=https://www.polyphone-soundfonts.com/
NEOTERM_PKG_DESCRIPTION="An open-source soundfont editor for creating musical instruments"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.3.0
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://github.com/davy7125/polyphone/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=ecf401f2a083bb5396032953bb3d051e39aa4483063da9546852219ad532605a
NEOTERM_PKG_DEPENDS="glib, libc++, libflac, libogg, librtmidi, libvorbis, openssl, portaudio, qcustomplot, qt5-qtbase, qt5-qtsvg, zlib"
NEOTERM_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools, qt5-qttools-cross-tools"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
DEFINES+=USE_LOCAL_STK
PKG_CONFIG=pkg-config
PREFIX=$NEOTERM_PREFIX
"

neoterm_step_pre_configure() {
	NEOTERM_PKG_SRCDIR+="/sources"
	NEOTERM_PKG_BUILDDIR="$NEOTERM_PKG_SRCDIR"
}

neoterm_step_configure() {
	"${NEOTERM_PREFIX}/opt/qt/cross/bin/qmake" \
		-spec "${NEOTERM_PREFIX}/lib/qt/mkspecs/neoterm-cross" \
		${NEOTERM_PKG_EXTRA_CONFIGURE_ARGS}
}
