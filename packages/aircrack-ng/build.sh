# root-packages
NEOTERM_PKG_HOMEPAGE="https://www.aircrack-ng.org/"
NEOTERM_PKG_DESCRIPTION="WiFi security auditing tools suite"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="Marlin Sööse <marlin.soose@laro.se>"
NEOTERM_PKG_VERSION=3:1.7
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/aircrack-ng/aircrack-ng/archive/refs/tags/${NEOTERM_PKG_VERSION:2}.tar.gz
NEOTERM_PKG_SHA256=05a704e3c8f7792a17315080a21214a4448fd2452c1b0dd5226a3a55f90b58c3
NEOTERM_PKG_DEPENDS="libc++, libnl, libpcap, libsqlite, openssl, pcre, zlib, iw, ethtool"
# static build gives errors:
#   error: undefined reference to 'ac_crypto_engine_init'
#   error: cannot find the library 'libaircrack-ce-wpa.la' or unhandled argument 'libaircrack-ce-wpa.la'
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-static
ac_cv_prog_RFKILL=$NEOTERM_PREFIX/bin/rfkill
--with-libpcap-include=$NEOTERM_PREFIX/include
--with-libpcap-lib=$NEOTERM_PREFIX/lib
--with-sqlite3=$NEOTERM_PREFIX
"

neoterm_step_pre_configure() {
	NOCONFIGURE=1 ./autogen.sh
}

neoterm_step_post_configure() {
	local _LT_VER=$(awk '/^LT_VER =/ { print $3 }' "$NEOTERM_PKG_BUILDDIR"/Makefile)
	local m
	for m in ce-wpa osdep; do
		ln -sfr $NEOTERM_PREFIX/lib/libaircrack-${m}{-$_LT_VER,}.so
	done
}
