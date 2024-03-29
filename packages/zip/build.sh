NEOTERM_PKG_HOMEPAGE=https://sourceforge.net/projects/infozip/
NEOTERM_PKG_DESCRIPTION="Tools for working with zip files"
NEOTERM_PKG_LICENSE="BSD"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.0
NEOTERM_PKG_REVISION=5
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/infozip/zip30.tar.gz
NEOTERM_PKG_SHA256=f0e8bb1f9b7eb0b01285495a2699df3a4b766784c1765a8f1aeedf63c0806369
NEOTERM_PKG_DEPENDS="libandroid-support, libbz2"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_configure() {
	cp unix/Makefile Makefile
}

neoterm_step_make() {
	LD="$CC $LDFLAGS" CC="$CC $CFLAGS $CPPFLAGS $LDFLAGS" make -j $NEOTERM_MAKE_PROCESSES generic
}
