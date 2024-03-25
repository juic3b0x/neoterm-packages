NEOTERM_PKG_HOMEPAGE=https://www.stunnel.org/
NEOTERM_PKG_DESCRIPTION="Socket wrapper which can provide TLS support to ordinary applications"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="5.72"
NEOTERM_PKG_SRCURL=https://www.stunnel.org/downloads/stunnel-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=3d532941281ae353319735144e4adb9ae489a10b7e309c58a48157f08f42e949
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="openssl"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--disable-shared --with-ssl=$NEOTERM_PREFIX --disable-fips"
NEOTERM_PKG_RM_AFTER_INSTALL="bin/stunnel3 share/man/man8/stunnel.*.8"
