TERMUX_PKG_HOMEPAGE=https://jcorporation.github.io/myMPD/
TERMUX_PKG_DESCRIPTION="A standalone and lightweight web-based MPD client"
TERMUX_PKG_LICENSE="GPL-3.0"
TERMUX_PKG_MAINTAINER="@neoterm"
TERMUX_PKG_VERSION="14.1.0"
TERMUX_PKG_SRCURL=https://github.com/jcorporation/myMPD/archive/refs/tags/v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=f4bdb265915384d9271426a7e53977e71094ab03c0b2be5df185a2976ce4c6e2
TERMUX_PKG_AUTO_UPDATE=true
TERMUX_PKG_DEPENDS="libflac, libid3tag, liblua54, openssl, pcre2, resolv-conf"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
-DMATH_LIB=m
-DMYMPD_STARTUP_SCRIPT=OFF
"
TERMUX_CMAKE_BUILD="Unix Makefiles"
