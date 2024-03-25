NEOTERM_PKG_HOMEPAGE=https://github.com/sqlcipher/sqlcipher
NEOTERM_PKG_DESCRIPTION="SQLCipher is an SQLite extension that provides 256 bit AES encryption of database files"
NEOTERM_PKG_LICENSE="BSD"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="4.5.6"
NEOTERM_PKG_SRCURL=https://github.com/sqlcipher/sqlcipher/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=e4a527e38e67090c1d2dc41df28270d16c15f7ca5210a3e7ec4c4b8fda36e28f
NEOTERM_PKG_DEPENDS="libedit, openssl"
NEOTERM_PKG_BUILD_DEPENDS="tcl"
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-tempstore=yes
--with-tcl=${NEOTERM_PREFIX}/lib
TCLLIBDIR=${NEOTERM_PREFIX}/lib/tcl8.6/sqlite
"

neoterm_step_pre_configure() {
	CPPFLAGS+=" -DSQLITE_HAS_CODEC"
}
