# x11-packages
NEOTERM_PKG_HOMEPAGE=https://www.ferzkopp.net/wordpress/2016/01/02/sdl_gfx-sdl2_gfx/
NEOTERM_PKG_DESCRIPTION="SDL-1.2 graphics drawing primitives, rotozoom and other supporting functions"
NEOTERM_PKG_LICENSE="ZLIB"
NEOTERM_PKG_LICENSE_FILE="LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.0.26
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://www.ferzkopp.net/Software/SDL_gfx-2.0/SDL_gfx-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=7ceb4ffb6fc63ffba5f1290572db43d74386cd0781c123bc912da50d34945446
NEOTERM_PKG_DEPENDS="sdl"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-mmx
"

neoterm_step_pre_configure() {
	cp $NEOTERM_PREFIX/share/aclocal/sdl.m4 m4/
	autoreconf -fi

	CPPFLAGS+=" -I$NEOTERM_PREFIX/include/SDL"
}
