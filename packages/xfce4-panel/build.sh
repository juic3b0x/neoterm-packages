NEOTERM_PKG_HOMEPAGE=https://www.xfce.org/
NEOTERM_PKG_DESCRIPTION="Panel for the XFCE environment"
NEOTERM_PKG_LICENSE="GPL-2.0, LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="4.18.6"
NEOTERM_PKG_SRCURL=https://archive.xfce.org/src/xfce/xfce4-panel/${NEOTERM_PKG_VERSION%.*}/xfce4-panel-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=21337161f58bb9b6e42760cb6883bc79beea27882aa6272b61f0e09d750d7c62
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="atk, exo, garcon, gdk-pixbuf, glib, gtk3, harfbuzz, libcairo, libice, libsm, libwnck, libx11, libxext, libxfce4ui, libxfce4util, pango, xfconf, zlib"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner"
NEOTERM_PKG_RECOMMENDS="desktop-file-utils, hicolor-icon-theme"
NEOTERM_PKG_DISABLE_GIR=false
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-gtk-doc-html=no
--enable-introspection=yes
--enable-vala=no
--disable-dbusmenu-gtk3
"

neoterm_step_pre_configure() {
	NEOTERM_PKG_VERSION=. neoterm_setup_gir
}
