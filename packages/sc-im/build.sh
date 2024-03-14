NEOTERM_PKG_HOMEPAGE=https://github.com/andmarti1424/sc-im
NEOTERM_PKG_DESCRIPTION="An improved version of sc, a spreadsheet calculator"
NEOTERM_PKG_LICENSE="BSD"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.8.3
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/andmarti1424/sc-im/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=5568f9987b6d26535c0e7a427158848f1bc03d829f74e41cbcf007d8704e9bd3
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libandroid-support, libandroid-wordexp, liblua51, libxls, libxlsxwriter, libxml2, libzip, ncurses"
NEOTERM_PKG_SUGGESTS="gnuplot"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	CFLAGS+=" $CPPFLAGS -I$NEOTERM_PREFIX/include/libandroid-support -DGNUPLOT"
	LDFLAGS+=" -landroid-wordexp"
	NEOTERM_PKG_BUILDDIR+="/src"
}
