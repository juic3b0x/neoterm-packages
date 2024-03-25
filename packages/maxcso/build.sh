NEOTERM_PKG_HOMEPAGE=https://github.com/unknownbrackets/maxcso
NEOTERM_PKG_DESCRIPTION="A fast ISO to CSO compression program for use with PSP and PS2 emulators"
NEOTERM_PKG_LICENSE="ISC, LGPL-2.1, Apache-2.0, MIT"
NEOTERM_PKG_LICENSE_FILE="LICENSE.md, README.md"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.13.0
NEOTERM_PKG_SRCURL=https://github.com/unknownbrackets/maxcso/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=af9c05add1a1d199ec184d3471081af1b91d591b2473800ea989c882fb632730
NEOTERM_PKG_DEPENDS="libc++, liblz4, libuv, zlib"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	CFLAGS+=" $CPPFLAGS"
	CXXFLAGS+=" $CPPFLAGS"
}

neoterm_step_post_make_install() {
	install -Dm600 -T $NEOTERM_PKG_SRCDIR/7zip/DOC/License.txt \
		$NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME/COPYING.7zip
	install -Dm600 -T $NEOTERM_PKG_SRCDIR/libdeflate/COPYING \
		$NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME/COPYING.libdeflate
	install -Dm600 -T $NEOTERM_PKG_SRCDIR/zopfli/COPYING \
		$NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME/COPYING.zopfli
}
