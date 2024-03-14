NEOTERM_PKG_HOMEPAGE=https://github.com/Aanok/jftui
NEOTERM_PKG_DESCRIPTION="jftui is a minimalistic, lightweight C99 command line client for the open source Jellyfin media server."
NEOTERM_PKG_LICENSE="Unlicense"
NEOTERM_PKG_MAINTAINER="Maxr1998 <max.rumpf1998@gmail.com>"
NEOTERM_PKG_VERSION="0.7.2"
NEOTERM_PKG_SRCURL=https://github.com/Aanok/jftui/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=692c914408f3cba6e052064a55967f872dcb7387f4e6ce50edca2adf865700a3
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libcurl, yajl, mpv"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	sed -i 's| -march=native||' Makefile
	sed -i 's|^CFLAGS=|override CFLAGS+=|' Makefile
	sed -i 's|^LFLAGS=|override LFLAGS+=|' Makefile
}

neoterm_step_make() {
	make CFLAGS="$CPPFLAGS" LFLAGS="$LDFLAGS"
}

neoterm_step_make_install() {
	install -Dm700 $NEOTERM_PKG_SRCDIR/build/jftui "$NEOTERM_PREFIX/bin/jftui"
}
