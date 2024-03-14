NEOTERM_PKG_HOMEPAGE=https://github.com/carlobaldassi/gimp-lqr-plugin
NEOTERM_PKG_DESCRIPTION="LiquidRescale plug-in for seam carving in GIMP"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.7.2
NEOTERM_PKG_SRCURL=https://github.com/carlobaldassi/gimp-lqr-plugin/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=a01ffdfc04e97167413b4bb11516d3bad28dadb84bbfacb5e6ed21959483ebe1
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_DEPENDS="gdk-pixbuf, gimp, glib, gtk2, liblqr"

neoterm_step_pre_configure() {
	CFLAGS+=" -fcommon"
}
