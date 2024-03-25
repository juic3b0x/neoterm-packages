NEOTERM_PKG_HOMEPAGE=https://mate-desktop.mate-desktop.dev/
NEOTERM_PKG_DESCRIPTION="mate-desktop contains the libmate-desktop library, the mate-about program as well as some desktop-wide documents."
NEOTERM_PKG_LICENSE="GPL-2.0, LGPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.28.2"
NEOTERM_PKG_SRCURL=https://github.com/mate-desktop/mate-desktop/releases/download/v$NEOTERM_PKG_VERSION/mate-desktop-$NEOTERM_PKG_VERSION.tar.xz
NEOTERM_PKG_SHA256=32bb4b792014b391c1e1b8ae9c18a82b4d447650984b4cba7d28e95564964aa2
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="atk, dconf, gdk-pixbuf, glib, gtk3, harfbuzz, libcairo, libx11, libxrandr, pango, startup-notification, zlib"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner, iso-codes"
NEOTERM_PKG_DISABLE_GIR=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-introspection=yes
"

neoterm_step_pre_configure() {
	neoterm_setup_gir
}
