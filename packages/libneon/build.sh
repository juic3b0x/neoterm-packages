NEOTERM_PKG_HOMEPAGE=https://notroj.github.io/neon/
NEOTERM_PKG_DESCRIPTION="An HTTP/1.1 and WebDAV client library, with a C interface"
NEOTERM_PKG_LICENSE="GPL-2.0, LGPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.33.0"
NEOTERM_PKG_SRCURL=https://notroj.github.io/neon/neon-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=659a5cc9cea05e6e7864094f1e13a77abbbdbab452f04d751a8c16a9447cf4b8
NEOTERM_PKG_DEPENDS="libexpat, openssl, zlib"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--with-ssl=openssl
--with-expat
"
