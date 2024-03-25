NEOTERM_PKG_HOMEPAGE=https://www.gnu.org/software/gnugo/
NEOTERM_PKG_DESCRIPTION="Program that plays the game of Go"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.8
NEOTERM_PKG_REVISION=5
NEOTERM_PKG_SRCURL=https://mirrors.kernel.org/gnu/gnugo/gnugo-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=da68d7a65f44dcf6ce6e4e630b6f6dd9897249d34425920bfdd4e07ff1866a72
NEOTERM_PKG_DEPENDS="ncurses, readline"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--with-readline"
NEOTERM_PKG_HOSTBUILD=true
NEOTERM_PKG_GROUPS="games"

neoterm_step_post_configure () {
	cp $NEOTERM_PKG_HOSTBUILD_DIR/patterns/mkeyes $NEOTERM_PKG_BUILDDIR/patterns/mkeyes
	cp $NEOTERM_PKG_HOSTBUILD_DIR/patterns/uncompress_fuseki $NEOTERM_PKG_BUILDDIR/patterns/uncompress_fuseki
	cp $NEOTERM_PKG_HOSTBUILD_DIR/patterns/joseki $NEOTERM_PKG_BUILDDIR/patterns/joseki
	cp $NEOTERM_PKG_HOSTBUILD_DIR/patterns/mkmcpat $NEOTERM_PKG_BUILDDIR/patterns/mkmcpat
	cp $NEOTERM_PKG_HOSTBUILD_DIR/patterns/mkpat $NEOTERM_PKG_BUILDDIR/patterns/mkpat
	touch -d "next hour" $NEOTERM_PKG_BUILDDIR/patterns/*
}
