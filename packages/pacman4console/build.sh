NEOTERM_PKG_HOMEPAGE=https://sites.google.com/site/doctormike/pacman.html
NEOTERM_PKG_DESCRIPTION="A 9 level ncurses pacman game with editor"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.3
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://ftp.debian.org/debian/pool/main/p/pacman4console/pacman4console_${NEOTERM_PKG_VERSION}.orig.tar.gz
NEOTERM_PKG_SHA256=9a5c4a96395ce4a3b26a9896343a2cdf488182da1b96374a13bf5d811679eb90
NEOTERM_PKG_DEPENDS="ncurses"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_GROUPS="games"

neoterm_step_post_make_install() {
	mkdir -p "$NEOTERM_PREFIX"/share/man/man1 "$NEOTERM_PREFIX"/share/man/man6
	install -Dm600 $NEOTERM_PKG_BUILDER_DIR/pacmanedit.1 "$NEOTERM_PREFIX"/share/man/man1/
	install -Dm600 $NEOTERM_PKG_BUILDER_DIR/pacman.6 "$NEOTERM_PREFIX"/share/man/man6/
}
