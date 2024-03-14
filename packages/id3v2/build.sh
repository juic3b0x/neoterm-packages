NEOTERM_PKG_HOMEPAGE=https://id3v2.sourceforge.net/
NEOTERM_PKG_DESCRIPTION="A command line id3v2 tag editor"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.1.12
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/id3v2/id3v2-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=8105fad3189dbb0e4cb381862b4fa18744233c3bbe6def6f81ff64f5101722bf
NEOTERM_PKG_DEPENDS="id3lib, libc++, zlib"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="PREFIX=$NEOTERM_PREFIX"

neoterm_step_post_configure() {
	make clean
}
