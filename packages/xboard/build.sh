NEOTERM_PKG_HOMEPAGE=https://www.gnu.org/software/xboard/
NEOTERM_PKG_DESCRIPTION="A graphical chessboard for the X Window System"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=4.9.1
NEOTERM_PKG_SRCURL=https://ftp.gnu.org/gnu/xboard/xboard-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=2b2e53e8428ad9b6e8dc8a55b3a5183381911a4dae2c0072fa96296bbb1970d6
NEOTERM_PKG_DEPENDS="glib, libcairo, librsvg, libx11, libxaw, libxmu, libxt, pango"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--without-gtk
"

neoterm_step_pre_configure() {
	CFLAGS+=" -fcommon"
}
