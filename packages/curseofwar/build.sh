NEOTERM_PKG_HOMEPAGE=http://a-nikolaev.github.io/curseofwar/
NEOTERM_PKG_DESCRIPTION="Fast-paced action strategy game focusing on high-level strategic planning"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.3.0
NEOTERM_PKG_REVISION=4
NEOTERM_PKG_SRCURL=https://github.com/a-nikolaev/curseofwar/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=2a90204d95a9f29a0e5923f43e65188209dc8be9d9eb93576404e3f79b8a652b
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_DEPENDS="libc++, ncurses"
NEOTERM_PKG_GROUPS="games"

neoterm_step_make_install () {
	mkdir -p $NEOTERM_PREFIX/share/man/man6
	cp curseofwar $NEOTERM_PREFIX/bin
	cp $NEOTERM_PKG_SRCDIR/curseofwar.6 $NEOTERM_PREFIX/share/man/man6
}
