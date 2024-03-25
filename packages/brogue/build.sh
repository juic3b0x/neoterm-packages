NEOTERM_PKG_HOMEPAGE=https://sites.google.com/site/broguegame/
NEOTERM_PKG_DESCRIPTION="Roguelike dungeon crawling game (community edition)"
NEOTERM_PKG_LICENSE="AGPL-V3"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.13"
NEOTERM_PKG_SRCURL=https://github.com/tmewett/BrogueCE/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=4c63e91639902d58565ab3c2852d89a4206cdd60200b585fa9d93d6a5881906c
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="ncurses"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_GROUPS="games"

neoterm_step_pre_configure () {
	CFLAGS+=" -fcommon"
	CC="$CC $CFLAGS $CPPFLAGS $LDFLAGS"
}

neoterm_step_make_install () {
	install -m700 bin/brogue $NEOTERM_PREFIX/bin
}
