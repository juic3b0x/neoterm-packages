NEOTERM_PKG_HOMEPAGE=https://gitlab.com/DavidGriffith/frotz
NEOTERM_PKG_DESCRIPTION="Interpreter for Infocom and other Z-machine interactive fiction (IF) games"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
# frotz does not depend on dialog or curl, but the zgames script we bundle below in neoterm_step_make_install() do.
NEOTERM_PKG_VERSION=2.54
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://gitlab.com/DavidGriffith/frotz/-/archive/${NEOTERM_PKG_VERSION}/frotz-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=a5ffc284ba9073382a604c21ef9d876c366c4964eeaebb6459ac830dd183bd98
NEOTERM_PKG_DEPENDS="ncurses, dialog, curl"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_GROUPS="games"

neoterm_step_pre_configure () {
	export CURSES_CFLAGS="-I$NEOTERM_PREFIX/include"
	export SYSCONFDIR="$NEOTERM_PREFIX/include"
	export SOUND_TYPE="none"
}

neoterm_step_post_make_install () {
	install -m755 $NEOTERM_PKG_BUILDER_DIR/zgames $NEOTERM_PREFIX/bin/zgames
}
