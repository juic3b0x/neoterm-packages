NEOTERM_PKG_HOMEPAGE=https://gitlab.com/azelpg/azpainter
NEOTERM_PKG_DESCRIPTION="Full color painting software for Unix-like systems for illustration drawing"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1:3.0.7"
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_SRCURL=https://gitlab.com/azelpg/azpainter/-/archive/v${NEOTERM_PKG_VERSION:2}/azpainter-${NEOTERM_PKG_VERSION:2}.tar.bz2
NEOTERM_PKG_SHA256=3ea54f36ef87603dbaa1f7661ac20f49fe836ecde2b43d3ab9f5d0f817302281
NEOTERM_PKG_DEPENDS="fontconfig, freetype, libandroid-shmem, libiconv, libjpeg-turbo, libpng, libtiff, libwebp, libx11, libxcursor, libxext, libxi, zlib"
NEOTERM_PKG_RECOMMENDS="hicolor-icon-theme"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	CPPFLAGS="-I$NEOTERM_PKG_SRCDIR/src/include $CPPFLAGS"
}

neoterm_step_configure() {
	neoterm_setup_ninja
	./configure --prefix="$NEOTERM_PREFIX" \
		CC="$CC" \
		CFLAGS="$CPPFLAGS $CFLAGS" \
		LDFLAGS="$LDFLAGS" \
		LIBS="-liconv -landroid-shmem -lz"
}

neoterm_step_make() {
	cd build
	ninja
}

neoterm_step_make_install() {
	cd build
	ninja install
}
