NEOTERM_PKG_HOMEPAGE=https://www.xfce.org/
NEOTERM_PKG_DESCRIPTION="Commonly used XFCE widgets among XFCE applications"
NEOTERM_PKG_LICENSE="LGPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
_MAJOR_VERSION=4.18
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.4
NEOTERM_PKG_SRCURL=https://archive.xfce.org/src/xfce/libxfce4ui/${_MAJOR_VERSION}/libxfce4ui-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=87eefe797c6d26de3f754de48872faf131f1b5fc93fb88e22f5c7886a842cb4c
NEOTERM_PKG_DEPENDS="atk, gdk-pixbuf, glib, gtk3, harfbuzz, libcairo, libice, libsm, libx11, libxfce4util, pango, startup-notification, xfconf, zlib"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner"
NEOTERM_PKG_RECOMMENDS="hicolor-icon-theme"
NEOTERM_PKG_DISABLE_GIR=false
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--with-vendor-info=NeoTerm
--enable-introspection=yes
--enable-vala=no
--enable-gladeui2=no
--enable-gtk-doc-html=no
"

neoterm_step_pre_configure() {
	neoterm_setup_gir
}
