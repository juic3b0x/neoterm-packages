NEOTERM_PKG_HOMEPAGE=https://ngircd.barton.de/
NEOTERM_PKG_DESCRIPTION="Free, portable and lightweight Internet Relay Chat server"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@yonle <yonle@protonmail.com>"
NEOTERM_PKG_VERSION=26.1
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL="https://github.com/ngircd/ngircd/releases/download/rel-${NEOTERM_PKG_VERSION}/ngircd-26.tar.xz"
NEOTERM_PKG_SHA256=56dcc6483058699fcdd8e54f5010eecee09824b93bad7ed5f18818e550d855c6
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_SED_REGEXP='s/^[^-]*-//;s/-.*//'
NEOTERM_PKG_DEPENDS="zlib, openssl"

# Termux does not use /sbin. Place the binary to $PATH/bin instead
# Also enable OpenSSL & IPv6 support
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--sbindir=$NEOTERM_PREFIX/bin
--with-openssl
--enable-ipv6
"

