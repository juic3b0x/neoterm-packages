NEOTERM_PKG_HOMEPAGE=https://gmic.eu
NEOTERM_PKG_DESCRIPTION="Full-featured framework for image processing"
NEOTERM_PKG_LICENSE="CeCILL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="3.3.5"
NEOTERM_PKG_SRCURL=https://gmic.eu/files/source/gmic_$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=052456e0d9dd6a3c1e102a857ae32150ee6d5cb02a1d2f810c197ec490e56c1b
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="fftw, imath, libc++, libcurl, libjpeg-turbo, libpng, libtiff, libx11, openexr, zlib"
NEOTERM_PKG_BUILD_DEPENDS="graphicsmagick"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_configure() {
	return
}

neoterm_step_make() {
	cd src/
	make STRIP="$STRIP" OPT_CFLAGS="$CXXFLAGS" cli cli_gm
}

neoterm_step_make_install() {
	cp src/gmic $NEOTERM_PREFIX/bin/
	cp src/gmic-gm $NEOTERM_PREFIX/bin/
	cp man/gmic.1.gz $NEOTERM_PREFIX/share/man/man1/
	cp man/gmic.1.gz $NEOTERM_PREFIX/share/man/man1/gmic-gm.1.gz
}
