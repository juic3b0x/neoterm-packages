NEOTERM_PKG_HOMEPAGE=https://mate-menus.mate-desktop.dev/
NEOTERM_PKG_DESCRIPTION="mate-menus contains the libmate-menu library, the layout configuration"
NEOTERM_PKG_LICENSE="GPL-2.0, LGPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.26.1
NEOTERM_PKG_SRCURL=https://github.com/mate-desktop/mate-menus/releases/download/v$NEOTERM_PKG_VERSION/mate-menus-$NEOTERM_PKG_VERSION.tar.xz
NEOTERM_PKG_SHA256=458d599ae5b650c7d21740f9fe954c4a838be45ed62ab40e20e306faf5dd1d8c
NEOTERM_PKG_DEPENDS="glib"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner"
NEOTERM_PKG_DISABLE_GIR=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-introspection=yes
"

neoterm_step_pre_configure() {
	neoterm_setup_gir
}
