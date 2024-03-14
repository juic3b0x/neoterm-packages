NEOTERM_PKG_HOMEPAGE=https://github.com/shellinabox/shellinabox
NEOTERM_PKG_DESCRIPTION="Implementation of a web server that can export arbitrary command line tools to a web based terminal emulator"
# License: GPL-2.0-with-OpenSSL-exception
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.21
NEOTERM_PKG_SRCURL=https://deb.debian.org/debian/pool/main/s/shellinabox/shellinabox_${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=4ec657182b3ec628c2a7b036b360011cef51a23104b2eb332eafede56528a632
NEOTERM_PKG_DEPENDS="openssl, openssl-tool, neoterm-auth (>= 1.2), zlib"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-login
--disable-pam
--disable-utmp
--disable-runtime-loading
"

neoterm_step_pre_configure() {
	export LIBS="-lssl -lcrypto"
	autoreconf -i
}
