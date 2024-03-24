TERMUX_PKG_HOMEPAGE=https://github.com/rfc1036/whois
TERMUX_PKG_DESCRIPTION="An intelligent Whois client"
TERMUX_PKG_LICENSE="GPL-2.0"
TERMUX_PKG_MAINTAINER="@neoterm"
TERMUX_PKG_VERSION="5.5.21"
TERMUX_PKG_SRCURL=https://github.com/rfc1036/whois/archive/refs/tags/v$TERMUX_PKG_VERSION.tar.gz
TERMUX_PKG_SHA256=4366a1c5e0e3e3e696de833bfa2620f8107d8fec9fc044c4a616eb805b08cc77
TERMUX_PKG_DEPENDS="libcrypt, libiconv, libidn2"
TERMUX_PKG_CONFLICTS="inetutils (<< 1.9.4-13)"
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_EXTRA_MAKE_ARGS="
prefix=$TERMUX_PREFIX
HAVE_ICONV=1
"

TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_UPDATE_TAG_TYPE="newest-tag"

termux_step_pre_configure() {
	CPPFLAGS+=" -DHAVE_CRYPT_H"
	LDFLAGS+=" -liconv"
}
