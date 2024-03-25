# X11 package
NEOTERM_PKG_HOMEPAGE=https://xorg.freedesktop.org/
NEOTERM_PKG_DESCRIPTION="X.Org X11 Protocol headers"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_LICENSE_FILE="COPYING-bigreqsproto, COPYING-compositeproto, COPYING-damageproto, COPYING-dmxproto, COPYING-dri2proto, COPYING-dri3proto, COPYING-evieproto, COPYING-fixesproto, COPYING-fontcacheproto, COPYING-fontsproto, COPYING-glproto, COPYING-inputproto, COPYING-kbproto, COPYING-lg3dproto, COPYING-pmproto, COPYING-presentproto, COPYING-printproto, COPYING-randrproto, COPYING-recordproto, COPYING-renderproto, COPYING-resourceproto, COPYING-scrnsaverproto, COPYING-trapproto, COPYING-videoproto, COPYING-x11proto, COPYING-xcmiscproto, COPYING-xextproto, COPYING-xf86bigfontproto, COPYING-xf86dgaproto, COPYING-xf86driproto, COPYING-xf86miscproto, COPYING-xf86rushproto, COPYING-xf86vidmodeproto, COPYING-xineramaproto, COPYING-xwaylandproto"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2023.2
NEOTERM_PKG_SRCURL=https://xorg.freedesktop.org/archive/individual/proto/xorgproto-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=b61fbc7db82b14ce2dc705ab590efc32b9ad800037113d1973811781d5118c2c
NEOTERM_PKG_DEPENDS="xorg-util-macros"
NEOTERM_PKG_CONFLICTS="x11-proto"
NEOTERM_PKG_REPLACES="x11-proto"
NEOTERM_PKG_NO_DEVELSPLIT=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="-Dlegacy=true"

NEOTERM_PKG_RM_AFTER_INSTALL="
include/X11/extensions/apple*
include/X11/extensions/windows*
include/X11/extensions/XKBgeom.h
lib/pkgconfig/applewmproto.pc
lib/pkgconfig/windowswmproto.pc
"

neoterm_step_pre_configure() {
	# Use meson instead of autotools.
	rm -f "$NEOTERM_PKG_SRCDIR"/configure
}
