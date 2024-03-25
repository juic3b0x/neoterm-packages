NEOTERM_PKG_HOMEPAGE=https://github.com/rakshasa/rtorrent/wiki
NEOTERM_PKG_DESCRIPTION="Libtorrent BitTorrent library"
NEOTERM_PKG_MAINTAINER="Krishna Kanhaiya @kcubeterm"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_VERSION=0.13.8
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://github.com/rakshasa/libtorrent/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=0f6c2e7ffd3a1723ab47fdac785ec40f85c0a5b5a42c1d002272205b988be722
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_DEPENDS="libc++, openssl, zlib"

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-aligned=true
--without-fastcgi
--with-zlib=$NEOTERM_PREFIX
"

neoterm_step_pre_configure() {
	./autogen.sh

	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
