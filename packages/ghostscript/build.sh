NEOTERM_PKG_HOMEPAGE=https://www.ghostscript.com/
NEOTERM_PKG_DESCRIPTION="Interpreter for the PostScript language and for PDF"
NEOTERM_PKG_LICENSE="AGPL-V3"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="10.02.1"
NEOTERM_PKG_SRCURL=https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs${NEOTERM_PKG_VERSION//.}/ghostpdl-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=25399af0ef5bb94f2a13c91dc785c128d14f16744c4c92fa7c86e011c23151d8
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_DEPENDS="fontconfig, freetype, jbig2dec, libandroid-support, libc++, libiconv, libidn, libjpeg-turbo, libpng, libtiff, littlecms, openjpeg, zlib"
NEOTERM_PKG_BUILD_DEPENDS="libexpat"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_lib_lcms2__cmsCreateMutex=yes
ac_cv_lib_pthread_pthread_create=yes
CCAUX=gcc
--build=$NEOTERM_BUILD_TUPLE
--with-arch_h=$NEOTERM_PKG_BUILDER_DIR/arch-${NEOTERM_ARCH}.h
--disable-cups
--disable-compile-inits
--without-pcl
--without-x
--with-system-libtiff
"
NEOTERM_PKG_MAKE_INSTALL_TARGET="install-so install"

neoterm_step_post_get_source() {
	rm -rdf $NEOTERM_PKG_SRCDIR/{expat,freetype,jbig2dec,jpeg,lcms2mt,libpng,openjpeg,tiff,zlib}
}

neoterm_step_pre_configure() {
	# Use `make -j1` otherwise build may fail with error
	# about missing 'arch.h'.
	NEOTERM_MAKE_PROCESSES=1
	CPPFLAGS+=" -I${NEOTERM_STANDALONE_TOOLCHAIN}/sysroot/usr/include/c++/v1"

	# Workaround for build break caused by `sha2.h` from `libmd` package:
	if [ -e "$NEOTERM_PREFIX/include/sha2.h" ]; then
		local inc="$NEOTERM_PKG_BUILDDIR/_include"
		mkdir -p "${inc}"
		ln -sf "$NEOTERM_PKG_SRCDIR/base/sha2.h" "${inc}/"
		CPPFLAGS="-I${inc} ${CPPFLAGS}"
	fi
}

neoterm_step_make() {
	make -j $NEOTERM_MAKE_PROCESSES \
		so all \
		${NEOTERM_PKG_EXTRA_MAKE_ARGS}
}

neoterm_step_post_make_install() {
	mv $NEOTERM_PREFIX/bin/gs{c,}
}
