NEOTERM_PKG_HOMEPAGE=https://github.com/sulkasormi/frogcomposband/
NEOTERM_PKG_DESCRIPTION="Open world Angband variant with many additions"
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_SRCURL=git+https://github.com/sulkasormi/frogcomposband
NEOTERM_PKG_VERSION=7.1.salmiak
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_DEPENDS="ncurses"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--disable-x11 --bindir=$NEOTERM_PREFIX/bin --sysconfdir=$NEOTERM_PREFIX/share/frogcomposband"
NEOTERM_PKG_RM_AFTER_INSTALL="share/angband/xtra share/angband/icons"

neoterm_step_pre_configure () {
	./autogen.sh
	perl -p -i -e 's|ncursesw5-config|ncursesw6-config|g' configure
}

neoterm_step_post_make_install () {
	rm -Rf $NEOTERM_PREFIX/share/frogcomposband/fonts
}

neoterm_step_install_license() {
	install -Dm600 $NEOTERM_PKG_BUILDER_DIR/LICENSE \
		$NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME/LICENSE
}
