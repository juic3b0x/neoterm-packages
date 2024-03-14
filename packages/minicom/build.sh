NEOTERM_PKG_HOMEPAGE=https://salsa.debian.org/minicom-team/minicom
NEOTERM_PKG_DESCRIPTION="Friendly menu driven serial communication program"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.9"
NEOTERM_PKG_SRCURL=https://salsa.debian.org/minicom-team/minicom/-/archive/${NEOTERM_PKG_VERSION}/minicom-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=21e609d1b58c5de06400f6e36ed3a5060711847a63bc984b6e994d9ad1641d37
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libiconv, ncurses"

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-socket
--disable-music
--enable-lock-dir=$NEOTERM_PREFIX/var/run
"

neoterm_step_pre_configure() {
	export CFLAGS+=" -fcommon"
	CPPFLAGS+=" -Dushort=u_short"
}
