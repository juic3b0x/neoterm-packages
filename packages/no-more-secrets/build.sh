NEOTERM_PKG_HOMEPAGE=https://github.com/bartobri/no-more-secrets
NEOTERM_PKG_DESCRIPTION="This project provides a command line tool called nms that recreates the famous data decryption effect"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.0.1
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/bartobri/no-more-secrets/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=4422e59bb3cf62bca3c73d1fdae771b83aab686cd044f73fe14b1b9c2af1cb1b
NEOTERM_PKG_DEPENDS="libandroid-support, ncurses"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="all all-ncurses"

neoterm_step_pre_configure() {
	CFLAGS+=" $CPPFLAGS"
	export NCURSES_CFLAGS="$(pkg-config --cflags ncurses)"
	export NCURSES_LIBS="$(pkg-config --libs ncurses)"
}
