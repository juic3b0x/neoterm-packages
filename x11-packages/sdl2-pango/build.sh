# Dead upstream.
NEOTERM_PKG_HOMEPAGE=https://sdl2pango.sourceforge.net/
NEOTERM_PKG_DESCRIPTION="SDL2 library for internationalized text rendering"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.1.5"
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/project/tuxpaint-sdl2/SDL2_Pango/SDL2_Pango-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SRCURL=https://github.com/markuskimius/SDL2_Pango/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=3b3fe6008445feb1fca61b17b9d950d688e49dcca60dbbf8667c0f980ddfc563
NEOTERM_PKG_DEPENDS="glib, pango, sdl2"

neoterm_step_pre_configure() {
	mkdir -p m4
	cp $NEOTERM_PREFIX/share/aclocal/sdl2.m4 m4/
	autoreconf -fi -Im4

	CPPFLAGS+=" -D__FT2_BUILD_UNIX_H__"
	CFLAGS+=" $($PKG_CONFIG sdl2 --cflags)"
	LDFLAGS+=" $($PKG_CONFIG sdl2 --libs)"
}

neoterm_step_post_configure() {
	# Avoid overlinking
	sed -i 's/ -shared / -Wl,--as-needed\0/g' ./libtool
}
