NEOTERM_PKG_HOMEPAGE=https://www.dechifro.org/dcraw/
NEOTERM_PKG_DESCRIPTION="Raw digital camera images decoding utility"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=9.28.0
NEOTERM_PKG_REVISION=6
NEOTERM_PKG_SRCURL=https://mirrors.dotsrc.org/pub/mirrors/exherbo/dcraw-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=2890c3da2642cd44c5f3bfed2c9b2c1db83da5cec09cc17e0fa72e17541fb4b9
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_DEPENDS="littlecms, libjasper, libjpeg-turbo"

neoterm_step_make_install() {
	# See the "install" script for flags:
	$CC $CFLAGS $CPPFLAGS $LDFLAGS dcraw.c -lm -ljasper -ljpeg -llcms2 -o $NEOTERM_PREFIX/bin/dcraw
	chmod +w dcraw.1 # Add missing write permission
	cp dcraw.1 $NEOTERM_PREFIX/share/man/man1/
}
