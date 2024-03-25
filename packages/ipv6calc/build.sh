NEOTERM_PKG_HOMEPAGE=https://www.deepspace6.net/projects/ipv6calc.html
NEOTERM_PKG_DESCRIPTION="Does some format changes and calculations of IPv6 addresses"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=4.1.0
NEOTERM_PKG_SRCURL=https://github.com/pbiering/ipv6calc/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=9c42edd9998f13465d275a3124cfdf72c93fd793d38f6d732124ac3f4b84e36e
NEOTERM_PKG_DEPENDS="openssl, perl"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--with-external-db=$NEOTERM_PREFIX/share/ipv6calc/db
--with-dbip-db=$NEOTERM_PREFIX/share/DBIP
--with-ip2location-db=$NEOTERM_PREFIX/share/IP2Location
"
NEOTERM_PKG_EXTRA_MAKE_ARGS="exec_prefix=$NEOTERM_PREFIX"

neoterm_step_pre_configure() {
	CFLAGS+=" $CPPFLAGS"
	LDFLAGS+=" -lcrypto -lm"
}
