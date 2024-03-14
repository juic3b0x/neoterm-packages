NEOTERM_PKG_HOMEPAGE=http://www.vanheusden.com/multitail/
NEOTERM_PKG_DESCRIPTION="Tool to monitor logfiles and command output in multiple windows in a terminal, colorize, filter and merge"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="7.1.2"
NEOTERM_PKG_SRCURL=https://github.com/folkertvanheusden/multitail/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=c8552e10093f0690b8baef84945753c878e234d7b3d0e3ff27e509ed5515998c
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_DEPENDS="libandroid-glob, ncurses, ncurses-ui-libs"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_CONFFILES="etc/multitail.conf"

neoterm_step_pre_configure() {
	CFLAGS+=" -DNCURSES_WIDECHAR"
	LDFLAGS+=" -landroid-glob"
}
