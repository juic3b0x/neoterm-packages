NEOTERM_PKG_HOMEPAGE="https://github.com/tenox7/ttyplot"
NEOTERM_PKG_DESCRIPTION="A realtime plotting utility for terminal with data input from stdin"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.6.2"
NEOTERM_PKG_SRCURL="https://github.com/tenox7/ttyplot/archive/refs/tags/$NEOTERM_PKG_VERSION.tar.gz"
NEOTERM_PKG_SHA256=99222721e2d89e1064546f29e678830ccaba9b75f276a4b6845cc091169787a0
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="ncurses"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="-e"

neoterm_step_pre_configure() {
	CPPFLAGS+=" -DNCURSES_WIDECHAR=1"
	CFLAGS+=" $CPPFLAGS"
}

neoterm_step_make_install() {
	install -Dm755 -t "$NEOTERM_PREFIX/bin" ttyplot
}
