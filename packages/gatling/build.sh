NEOTERM_PKG_HOMEPAGE=https://www.fefe.de/gatling/
NEOTERM_PKG_DESCRIPTION="A high performance http, ftp and smb server"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.16
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://www.fefe.de/gatling/gatling-$NEOTERM_PKG_VERSION.tar.xz
NEOTERM_PKG_SHA256=5f96438ee201d7f1f6c2e0849ff273b196bdc7493f29a719ce8ed08c8be6365b
NEOTERM_PKG_DEPENDS="libcrypt, libiconv, openssl, zlib"
NEOTERM_PKG_BUILD_DEPENDS="libcap, libowfat"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="
prefix=$NEOTERM_PREFIX
MANDIR=$NEOTERM_PREFIX/share/man
"

neoterm_step_pre_configure() {
	CFLAGS+=" $CPPFLAGS"
	LDFLAGS+=" -lcrypt -lcrypto -liconv"
}
