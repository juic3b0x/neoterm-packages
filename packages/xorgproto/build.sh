# X11 package
TERMUX_PKG_HOMEPAGE=https://xorg.freedesktop.org/
TERMUX_PKG_DESCRIPTION="X.Org X11 Protocol headers"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_LICENSE_FILE="COPYING-bigreqsproto, COPYING-compositeproto, COPYING-damageproto, COPYING-dmxproto, COPYING-dri2proto, COPYING-dri3proto, COPYING-evieproto, COPYING-fixesproto, COPYING-fontcacheproto, COPYING-fontsproto, COPYING-glproto, COPYING-inputproto, COPYING-kbproto, COPYING-lg3dproto, COPYING-pmproto, COPYING-presentproto, COPYING-printproto, COPYING-randrproto, COPYING-recordproto, COPYING-renderproto, COPYING-resourceproto, COPYING-scrnsaverproto, COPYING-trapproto, COPYING-videoproto, COPYING-x11proto, COPYING-xcmiscproto, COPYING-xextproto, COPYING-xf86bigfontproto, COPYING-xf86dgaproto, COPYING-xf86driproto, COPYING-xf86miscproto, COPYING-xf86rushproto, COPYING-xf86vidmodeproto, COPYING-xineramaproto, COPYING-xwaylandproto"
TERMUX_PKG_MAINTAINER="@neoterm"
TERMUX_PKG_VERSION=2023.2
TERMUX_PKG_SRCURL=https://xorg.freedesktop.org/archive/individual/proto/xorgproto-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=b61fbc7db82b14ce2dc705ab590efc32b9ad800037113d1973811781d5118c2c
TERMUX_PKG_DEPENDS="xorg-util-macros"
TERMUX_PKG_CONFLICTS="x11-proto"
TERMUX_PKG_REPLACES="x11-proto"
TERMUX_PKG_NO_DEVELSPLIT=true
TERMUX_PKG_PLATFORM_INDEPENDENT=true

TERMUX_PKG_EXTRA_CONFIGURE_ARGS="-Dlegacy=true"

TERMUX_PKG_RM_AFTER_INSTALL="
include/X11/extensions/apple*
include/X11/extensions/windows*
include/X11/extensions/XKBgeom.h
lib/pkgconfig/applewmproto.pc
lib/pkgconfig/windowswmproto.pc
"

termux_step_pre_configure() {
	# Use meson instead of autotools.
	rm -f "$TERMUX_PKG_SRCDIR"/configure
}
