NEOTERM_PKG_HOMEPAGE=https://sourceforge.net/projects/boinctui/
NEOTERM_PKG_DESCRIPTION="curses based manager for Boinc client"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.7.0
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL="https://sourceforge.net/projects/boinctui/files/boinctui_${NEOTERM_PKG_VERSION}.tar.gz"
NEOTERM_PKG_SHA256=22eb46dea8b111e2e16ceb50f2668577216c1563c815b1719b2b680d485d75c9
NEOTERM_PKG_DEPENDS="libandroid-support, libc++, libexpat, ncurses, ncurses-ui-libs, openssl"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--without-gnutls --mandir=${NEOTERM_PREFIX}/share/man"

neoterm_step_pre_configure() {
	export CFLAGS+=" -flto"
	export CXXFLAGS+=" -flto"
	autoreconf -fi
}
