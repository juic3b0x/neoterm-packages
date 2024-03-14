NEOTERM_PKG_HOMEPAGE=https://lftp.tech/
NEOTERM_PKG_DESCRIPTION="FTP/HTTP client and file transfer program"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=4.9.2
NEOTERM_PKG_REVISION=6
NEOTERM_PKG_SRCURL=http://lftp.yar.ru/ftp/lftp-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=a37589c61914073f53c5da0e68bd233b41802509d758a022000e1ae2076da733
NEOTERM_PKG_DEPENDS="libandroid-support, libc++, libexpat, libiconv, openssl, readline, libidn2, zlib"

# (1) Android has dn_expand, but lftp assumes that dn_skipname then exists, which it does not on android.
# (2) Use --with-openssl to use openssl instead of gnutls.
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_header_glob_h=no
ac_cv_func_dn_expand=no
--with-openssl=$NEOTERM_PREFIX
--with-expat=$NEOTERM_PREFIX
--with-readline=$NEOTERM_PREFIX
--with-zlib=$NEOTERM_PREFIX
"

neoterm_step_pre_configure() {
	CXXFLAGS+=" -DNO_INLINE_GETPASS=1"
}
