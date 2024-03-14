NEOTERM_PKG_HOMEPAGE=https://www.gnu.org/software/gnushogi/
NEOTERM_PKG_DESCRIPTION="Program that plays the game of Shogi, also known as Japanese Chess"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.4.2
NEOTERM_PKG_REVISION=4
NEOTERM_PKG_SRCURL=https://mirrors.kernel.org/gnu/gnushogi/gnushogi-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=1ecc48a866303c63652552b325d685e7ef5e9893244080291a61d96505d52b29
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_lib_curses_clrtoeol=yes --with-curses"
NEOTERM_PKG_RM_AFTER_INSTALL="info/gnushogi.info"
NEOTERM_PKG_DEPENDS="ncurses"
NEOTERM_PKG_HOSTBUILD=true
NEOTERM_PKG_GROUPS="games"

neoterm_step_pre_configure() {
	CFLAGS+=" $CPPFLAGS -fcommon"
}

neoterm_step_post_configure () {
	cp $NEOTERM_PKG_HOSTBUILD_DIR/gnushogi/pat2inc $NEOTERM_PKG_BUILDDIR/gnushogi/pat2inc
	# Update timestamps so that the binaries does not get rebuilt:
	touch -d "next hour" $NEOTERM_PKG_BUILDDIR/gnushogi/pat2inc
}
