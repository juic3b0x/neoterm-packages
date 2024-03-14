NEOTERM_PKG_HOMEPAGE=https://benkibbey.wordpress.com/cboard/
NEOTERM_PKG_DESCRIPTION="PGN browser, editor and chess engine frontend"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.7.5
NEOTERM_PKG_REVISION=4
NEOTERM_PKG_SRCURL=http://downloads.sourceforge.net/project/c-board/${NEOTERM_PKG_VERSION}/cboard-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=dd748039f3531653e1573577cd814741524e1b16e16e3a841ef512e5150da6a0
NEOTERM_PKG_DEPENDS="libandroid-support,libandroid-glob,gnuchess, ncurses, ncurses-ui-libs"
NEOTERM_PKG_GROUPS="games"

neoterm_step_pre_configure() {
	CPPFLAGS+=" -DNCURSES_WIDECHAR"
	CFLAGS+=" -DLINE_MAX=_POSIX2_LINE_MAX -fcommon"
	LDFLAGS+=" -landroid-glob"

	if $NEOTERM_DEBUG_BUILD; then
		# When doing debug build, -D_FORTIFY_SOURCE=2 gives this error:
		# /home/builder/.neoterm-build/cboard/src/libchess/pgn.c:2235:33: error: 'umask' called with invalid mode
		# mode = umask(600);
		export CFLAGS=${CFLAGS/-D_FORTIFY_SOURCE=2/}
	fi
}
