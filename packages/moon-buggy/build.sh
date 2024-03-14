NEOTERM_PKG_HOMEPAGE=https://github.com/seehuhn/moon-buggy
NEOTERM_PKG_DESCRIPTION="Simple game where you drive a car across the moon's surface"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_DEPENDS="ncurses"
NEOTERM_PKG_VERSION=1.0.51
NEOTERM_PKG_REVISION=5
# Main site down 2017-01-06.
# NEOTERM_PKG_SRCURL=http://m.seehuhn.de/programs/moon-buggy-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SRCURL=ftp://ftp.netbsd.org/pub/pkgsrc/distfiles/moon-buggy-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=352dc16ccae4c66f1e87ab071e6a4ebeb94ff4e4f744ce1b12a769d02fe5d23f
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--sharedstatedir=$NEOTERM_PREFIX/var"
NEOTERM_PKG_GROUPS="games"

neoterm_step_make_install () {
	mkdir -p $NEOTERM_PREFIX/share/man/man6
	cp moon-buggy $NEOTERM_PREFIX/bin
	cp moon-buggy.6 $NEOTERM_PREFIX/share/man/man6
}
