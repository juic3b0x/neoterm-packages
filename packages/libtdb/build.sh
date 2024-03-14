NEOTERM_PKG_HOMEPAGE=https://tdb.samba.org/
NEOTERM_PKG_DESCRIPTION="A trivial database system"
NEOTERM_PKG_LICENSE="LGPL-3.0, GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.4.10"
NEOTERM_PKG_SRCURL=https://samba.org/ftp/tdb/tdb-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=02338e33c16c21c9e29571cef523e76b2b708636254f6f30c6cf195d48c62daf
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libbsd"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--cross-compile
--cross-answers cross-answers.txt
--disable-python
"

neoterm_step_pre_configure() {
	sed 's:@NEOTERM_ARCH@:'$NEOTERM_ARCH':g' \
		$NEOTERM_PKG_BUILDER_DIR/cross-answers.txt > cross-answers.txt
}

neoterm_step_configure() {
	./configure \
		--prefix=$NEOTERM_PREFIX \
		--host=$NEOTERM_HOST_PLATFORM \
		$NEOTERM_PKG_EXTRA_CONFIGURE_ARGS
}
