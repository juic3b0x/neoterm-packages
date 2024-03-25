NEOTERM_PKG_HOMEPAGE=https://mate-panel.mate-desktop.dev/
NEOTERM_PKG_DESCRIPTION="mate-panel contains the MATE panel, the libmate-panel-applet library and several applets"
NEOTERM_PKG_LICENSE="GPL-2.0, LGPL-2.0"
NEOTERM_PKG_VERSION="1.28.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_SRCURL=https://github.com/mate-desktop/mate-panel/releases/download/v$NEOTERM_PKG_VERSION/mate-panel-$NEOTERM_PKG_VERSION.tar.xz
NEOTERM_PKG_SHA256=b3bd04a094d0eb5bd7dc3380ef6f0c49d9a9d5209733d7ccd7b46d066a208cba
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="atk, gdk-pixbuf, glib, gtk3, harfbuzz, libcairo, libice, libmateweather, libsm, libwnck, libx11, libxrandr, mate-desktop, mate-menus, pango, zlib"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner"
NEOTERM_PKG_DISABLE_GIR=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-introspection=yes
"

neoterm_step_pre_configure() {
	neoterm_setup_gir
}
