NEOTERM_PKG_HOMEPAGE=https://www.freedesktop.org/wiki/Software/LibXklavier/
NEOTERM_PKG_DESCRIPTION="High-level API for X Keyboard Extension"
NEOTERM_PKG_LICENSE="LGPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=5.4
NEOTERM_PKG_REVISION=25
NEOTERM_PKG_SRCURL=https://gitlab.freedesktop.org/archived-projects/libxklavier/-/archive/libxklavier-${NEOTERM_PKG_VERSION}/libxklavier-libxklavier-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=e1638599e9229e6f6267b70b02e41940b98ba29b3a37e221f6e59ff90100c3da
NEOTERM_PKG_DEPENDS="glib, iso-codes, libx11, libxi, libxkbfile, libxml2, xkeyboard-config, xorg-xkbcomp"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner, valac"
NEOTERM_PKG_DISABLE_GIR=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-introspection
--with-xkb-base=$NEOTERM_PREFIX/share/X11/xkb
--with-xkb-bin-base=$NEOTERM_PREFIX/bin
"

neoterm_step_pre_configure() {
	neoterm_setup_gir

	NOCONFIGURE=1 ./autogen.sh
}
