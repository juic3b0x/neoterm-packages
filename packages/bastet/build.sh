NEOTERM_PKG_HOMEPAGE=http://fph.altervista.org/prog/bastet.html
NEOTERM_PKG_DESCRIPTION="Tetris clone with 'bastard' block-choosing AI"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.43.2
NEOTERM_PKG_REVISION=9
NEOTERM_PKG_SRCURL=https://github.com/fph/bastet/archive/$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=f219510afc1d83e4651fbffd5921b1e0b926d5311da4f8fa7df103dc7f2c403f
NEOTERM_PKG_DEPENDS="libc++, ncurses"
NEOTERM_PKG_BUILD_DEPENDS="boost-headers, boost-static"
NEOTERM_PKG_EXTRA_MAKE_ARGS=" BOOST_PO=$NEOTERM_PREFIX/lib/libboost_program_options.a"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_GROUPS="games"
