NEOTERM_PKG_HOMEPAGE=https://sourceforge.net/projects/infozip/
NEOTERM_PKG_DESCRIPTION="Tools for working with zip files"
NEOTERM_PKG_LICENSE="BSD"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=6.0
NEOTERM_PKG_REVISION=9
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/infozip/unzip60.tar.gz
NEOTERM_PKG_SHA256=036d96991646d0449ed0aa952e4fbe21b476ce994abc276e49d30e686708bd37
NEOTERM_PKG_DEPENDS="libbz2"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_configure() {
	cp unix/Makefile Makefile
}

neoterm_step_make() {
	CFLAGS+=" $CPPFLAGS"
	CFLAGS+=" -DACORN_FTYPE_NFS"
	CFLAGS+=" -DWILD_STOP_AT_DIR"
	CFLAGS+=" -DLARGE_FILE_SUPPORT"
	CFLAGS+=" -DUNICODE_SUPPORT"
	CFLAGS+=" -DUNICODE_WCHAR"
	CFLAGS+=" -DUTF8_MAYBE_NATIVE"
	CFLAGS+=" -DNO_LCHMOD"
	CFLAGS+=" -DDATE_FORMAT=DF_YMD"
	CFLAGS+=" -DUSE_BZIP2"
	CFLAGS+=" -DNOMEMCPY"
	CFLAGS+=" -DNO_WORKING_ISPRINT"
	CFLAGS+=" -I."

	make -f unix/Makefile prefix=$NEOTERM_PREFIX D_USE_BZ2=-DUSE_BZIP2 \
		L_BZ2=-lbz2 LF2="$LDFLAGS" CC="$CC" CF="$CFLAGS" LD="$CC" unzips
}

neoterm_step_make_install() {
	make -f unix/Makefile prefix=$NEOTERM_PREFIX install
}
