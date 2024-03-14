NEOTERM_PKG_HOMEPAGE=https://github.com/abishekvashok/cmatrix
NEOTERM_PKG_DESCRIPTION="Command producing a Matrix-style animation"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.0
NEOTERM_PKG_SRCURL=https://github.com/abishekvashok/cmatrix/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=ad93ba39acd383696ab6a9ebbed1259ecf2d3cf9f49d6b97038c66f80749e99a
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--mandir=$NEOTERM_PREFIX/share/man"
NEOTERM_PKG_DEPENDS="ncurses"

neoterm_step_pre_configure() {
	autoreconf -i

	export ac_cv_file__usr_lib_kbd_consolefonts=no
	export ac_cv_file__usr_share_consolefonts=no
	export ac_cv_file__usr_lib_X11_fonts_misc=no
	export ac_cv_file__usr_X11R6_lib_X11_fonts_misc=no
}
