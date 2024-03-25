NEOTERM_PKG_HOMEPAGE=https://lazyread.sourceforge.net/
NEOTERM_PKG_DESCRIPTION="An auto-scroller, pager, and e-book reader all in one"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.0
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://sourceforge.net/projects/lazyread/files/lazyread/lazyread%20${NEOTERM_PKG_VERSION}/lazyread-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=7e462c5c9fe104d69e410c537336af838a30a030699dd9320f75fe85a20746a1
NEOTERM_PKG_DEPENDS="coreutils, lesspipe, ncurses"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	$CC $CPPFLAGS $CFLAGS lazyread.c -o lazyread $LDFLAGS -lncurses
}

neoterm_step_make_install() {
	install -Dm700 lazyread $NEOTERM_PREFIX/bin/lazyread
}
