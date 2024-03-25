NEOTERM_PKG_HOMEPAGE=https://gpac.wp.imt.fr/
NEOTERM_PKG_DESCRIPTION="An open-source multimedia framework focused on modularity and standards compliance"
# License: LGPL-2.1-or-later
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.2.1
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://github.com/gpac/gpac/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=8173ecc4143631d7f2c59f77e1144b429ccadb8de0d53a4e254389fb5948d8b8
NEOTERM_PKG_DEPENDS="ffmpeg, freetype, liba52, libjpeg-turbo, liblzma, libmad, libnghttp2, libogg, libpng, libtheora, libvorbis, openjpeg, openssl, pulseaudio, xvidcore, zlib"
NEOTERM_PKG_EXTRA_MAKE_ARGS="STRIP=:"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--disable-x11"

neoterm_step_pre_configure() {
	CFLAGS+=" -fPIC"
	for f in $CFLAGS $CPPFLAGS; do
		NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" --extra-cflags=$f"
	done
	for f in $LDFLAGS; do
		NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" --extra-ldflags=$f"
	done
}
