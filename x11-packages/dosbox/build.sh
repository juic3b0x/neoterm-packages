NEOTERM_PKG_HOMEPAGE=https://sourceforge.net/projects/dosbox/
NEOTERM_PKG_DESCRIPTION="Emulator with builtin DOS for running DOS Games"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.74.3
NEOTERM_PKG_REVISION=21
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/dosbox/dosbox-${NEOTERM_PKG_VERSION/.3/-3}.tar.gz
NEOTERM_PKG_SHA256=c0d13dd7ed2ed363b68de615475781e891cd582e8162b5c3669137502222260a
NEOTERM_PKG_DEPENDS="libc++, libpng, libx11, sdl, sdl-net, zlib"

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-dynamic-x86
--disable-fpu-x86
--disable-opengl
"
