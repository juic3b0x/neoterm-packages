NEOTERM_PKG_HOMEPAGE=https://mcrypt.sourceforge.net/
NEOTERM_PKG_DESCRIPTION="A library which provides a uniform interface to several symmetric encryption algorithms"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.5.8
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/mcrypt/libmcrypt-$NEOTERM_PKG_VERSION.tar.bz2
NEOTERM_PKG_SHA256=bf2f1671f44af88e66477db0982d5ecb5116a5c767b0a0d68acb34499d41b793
NEOTERM_PKG_BREAKS="libmcrypt-dev"
NEOTERM_PKG_REPLACES="libmcrypt-dev"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--mandir=$NEOTERM_PREFIX/share/man"
