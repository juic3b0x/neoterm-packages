NEOTERM_PKG_HOMEPAGE=http://lynx.browser.org/
NEOTERM_PKG_DESCRIPTION="The text web browser"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.8.9rel.1
NEOTERM_PKG_REVISION=7
NEOTERM_PKG_SRCURL=https://invisible-mirror.net/archives/lynx/tarballs/lynx${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=387f193d7792f9cfada14c60b0e5c0bff18f227d9257a39483e14fa1aaf79595
NEOTERM_PKG_DEPENDS="libiconv, ncurses, openssl, libbz2, libidn, zlib"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--with-screen=ncursesw --enable-widec --enable-scrollbar --enable-nested-tables --enable-htmlized-cfg --with-ssl --with-zlib --with-bzlib --enable-cjk --enable-japanese-utf8 --enable-progressbar --enable-prettysrc --enable-forms-options --enable-8bit-toupper --enable-ascii-ctypes --disable-font-switch --with-mime-libdir=$NEOTERM_PREFIX/etc"

## set default paths for tools that may be used in runtime by 'lynx' binary
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_BZIP2=${NEOTERM_PREFIX}/bin/bzip2"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_COMPRESS=${NEOTERM_PREFIX}/bin/compress"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_GZIP=${NEOTERM_PREFIX}/bin/gzip"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_INSTALL=${NEOTERM_PREFIX}/bin/install"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_MSGINIT=${NEOTERM_PREFIX}/bin/msginit"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_MV=${NEOTERM_PREFIX}/bin/mv"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_RM=${NEOTERM_PREFIX}/bin/rm"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_TAR=${NEOTERM_PREFIX}/bin/tar"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_TELNET=${NEOTERM_PREFIX}/bin/telnet"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_UNCOMPRESS=${NEOTERM_PREFIX}/bin/uncompress"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_UNZIP=${NEOTERM_PREFIX}/bin/unzip"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_UUDECODE=${NEOTERM_PREFIX}/bin/uudecode"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_ZCAT=${NEOTERM_PREFIX}/bin/zcat"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_path_ZIP=${NEOTERM_PREFIX}/bin/zip"

neoterm_step_pre_configure() {
	CC+=" $LDFLAGS"
	unset LDFLAGS
}

neoterm_step_make_install() {
	make uninstall
	make install
}
