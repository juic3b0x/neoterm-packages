NEOTERM_PKG_HOMEPAGE=https://docs.xfce.org/xfce/thunar/start
NEOTERM_PKG_DESCRIPTION="Modern file manager for XFCE environment"
NEOTERM_PKG_LICENSE="GPL-2.0, LGPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="4.18.10"
NEOTERM_PKG_SRCURL=https://archive.xfce.org/src/xfce/thunar/${NEOTERM_PKG_VERSION%.*}/thunar-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=e8308a1f139602d8c125f594bfcebb063b7dac1fbb6e14293bab4cdb3ecf1d08
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="atk, desktop-file-utils, exo, gdk-pixbuf, glib, gtk3, harfbuzz, libcairo, libexif, libice, libnotify, libsm, libx11, libxfce4ui, libxfce4util, pango, pcre2, shared-mime-info, xfce4-panel, xfconf, zlib"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner"
NEOTERM_PKG_RECOMMENDS="gvfs, hicolor-icon-theme, thunar-archive-plugin, tumbler"
NEOTERM_PKG_DISABLE_GIR=false
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-gtk-doc-html=no
--enable-introspection=yes
"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	NEOTERM_PKG_VERSION=. neoterm_setup_gir
}
