NEOTERM_PKG_HOMEPAGE=https://rephial.org/
NEOTERM_PKG_DESCRIPTION="Dungeon exploration adventure game"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="4.2.5"
NEOTERM_PKG_SHA256=2a27ce296310c4cbf960e2eb41ef55d383e546f24533446cf224119498a99651
NEOTERM_PKG_SRCURL=https://github.com/angband/angband/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_DEPENDS="ncurses"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-x11
--bindir=$NEOTERM_PREFIX/bin
--sysconfdir=$NEOTERM_PREFIX/share/angband
"
NEOTERM_PKG_RM_AFTER_INSTALL="
share/angband/fonts
share/angband/icons
share/angband/sounds
share/angband/xtra
"
NEOTERM_PKG_GROUPS="games"

neoterm_step_pre_configure () {
	./autogen.sh
	perl -p -i -e 's|ncursesw5-config|ncursesw6-config|g' configure
}
