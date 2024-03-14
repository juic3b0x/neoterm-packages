NEOTERM_PKG_HOMEPAGE=https://netpbm.sourceforge.net/
NEOTERM_PKG_DESCRIPTION="Toolkit for manipulation of graphic images of different formats"
NEOTERM_PKG_LICENSE="non-free"
NEOTERM_PKG_LICENSE_FILE="doc/copyright_summary"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1:10.73.43
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/project/netpbm/super_stable/${NEOTERM_PKG_VERSION:2}/netpbm-${NEOTERM_PKG_VERSION:2}.tgz
NEOTERM_PKG_SHA256=f9fd9a7f932258224d1925bfce61396a15e0fad93e3853d6324ac308d1adebf8
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_DEPENDS="libjpeg-turbo, libpng, libtiff, libx11, libxml2"
NEOTERM_PKG_BREAKS="netpbm-dev"
NEOTERM_PKG_REPLACES="netpbm-dev"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_configure() {
	# Put the android libpng-config script in the path (before the host one):
	NEOTERM_PKG_LIBPNG_CONFIG_DIR=$NEOTERM_PKG_TMPDIR/libpng-config
	mkdir -p $NEOTERM_PKG_LIBPNG_CONFIG_DIR
	cp $NEOTERM_PREFIX/bin/libpng-config $NEOTERM_PKG_LIBPNG_CONFIG_DIR/
	export PATH=$NEOTERM_PKG_LIBPNG_CONFIG_DIR:$PATH

	# See $SRC/doc/INSTALL about netpbm build system. For automatic builds it recommends just copying config.mk.in
	cd $NEOTERM_PKG_SRCDIR
	cp config.mk.in config.mk
	echo "AR = $AR" >> config.mk
	echo "RANLIB = $RANLIB" >> config.mk
	echo "CC = $CC" >> config.mk
	echo "CFLAGS = $CFLAGS" >> config.mk
	echo "CFLAGS_SHLIB = -fPIC" >> config.mk
	echo "LDFLAGS = $LDFLAGS" >> config.mk
	echo "STATICLIB_TOO = n" >> config.mk
	echo "INTTYPES_H = <inttypes.h>" >> config.mk
	export STRIPPROG=$STRIP

	echo "CC_FOR_BUILD = cc" >> config.mk
	echo "LD_FOR_BUILD = cc" >> config.mk
	echo "CFLAGS_FOR_BUILD = " >> config.mk
	echo "LDFLAGS_FOR_BUILD = " >> config.mk
	echo "JPEGLIB = ${NEOTERM_PREFIX}/lib/libjpeg.so" >> config.mk
	echo "TIFFLIB = ${NEOTERM_PREFIX}/lib/libtiff.so" >> config.mk
	echo "TIFFLIB_NEEDS_Z = N" >> config.mk

	cp $NEOTERM_PKG_BUILDER_DIR/standardppmdfont.c lib/
}

neoterm_step_make_install() {
	rm -Rf /tmp/netpbm
	make -j 1 package pkgdir=/tmp/netpbm
	./installnetpbm
}
