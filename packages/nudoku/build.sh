NEOTERM_PKG_HOMEPAGE=http://jubalh.github.io/nudoku/
NEOTERM_PKG_DESCRIPTION="ncurses based sudoku game"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.1.0
NEOTERM_PKG_SRCURL=https://github.com/jubalh/nudoku/archive/$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=eeff7f3adea5bfe7b88bf7683d68e9a597aabd1442d1621f21760c746400b924
NEOTERM_PKG_DEPENDS="ncurses"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_GROUPS="games"

neoterm_step_pre_configure() {
	autoreconf -i
}
