NEOTERM_PKG_HOMEPAGE=https://sourceware.org/elfutils/
NEOTERM_PKG_DESCRIPTION="ELF object file access library"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.190"
NEOTERM_PKG_SRCURL="https://sourceware.org/elfutils/ftp/${NEOTERM_PKG_VERSION}/elfutils-${NEOTERM_PKG_VERSION}.tar.bz2"
NEOTERM_PKG_SHA256=8e00a3a9b5f04bc1dc273ae86281d2d26ed412020b391ffcc23198f10231d692
# libandroid-support for langinfo.
NEOTERM_PKG_DEPENDS="libandroid-support, zlib, zstd"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_c99=yes --disable-symbol-versioning"
NEOTERM_PKG_CONFLICTS="libelf-dev"
NEOTERM_PKG_REPLACES="libelf-dev"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	CXXFLAGS+=" -Wno-unused-const-variable -Wno-error=unused-function"
	CFLAGS+=" -Wno-error=unused-value -Wno-error=format-nonliteral -Wno-error -Wno-error=unused-function"

	# Exposes ACCESSPERMS in <sys/stat.h> which elfutils uses
	CFLAGS+=" -D__USE_BSD"

	CFLAGS+=" -DFNM_EXTMATCH=0"

	if [ "$NEOTERM_ARCH" = "arm" ]; then
		CFLAGS="${CFLAGS/-Oz/-O1}"
	fi

	cp $NEOTERM_PKG_BUILDER_DIR/stdio_ext.h .
	cp $NEOTERM_PKG_BUILDER_DIR/obstack.h .
	cp $NEOTERM_PKG_BUILDER_DIR/qsort_r.h .
	cp $NEOTERM_PKG_BUILDER_DIR/aligned_alloc.c libelf
	cp -r $NEOTERM_PKG_BUILDER_DIR/search src/

	autoreconf -ivf
}
