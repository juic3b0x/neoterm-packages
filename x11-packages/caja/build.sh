NEOTERM_PKG_HOMEPAGE=https://mate-desktop.org/
NEOTERM_PKG_DESCRIPTION="The file manager for the MATE desktop"
NEOTERM_PKG_LICENSE="GPL-2.0, LGPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.28.0"
NEOTERM_PKG_SRCURL=https://pub.mate-desktop.org/releases/${NEOTERM_PKG_VERSION%.*}/caja-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=1e3014ce1455817ec2ef74d09efdfb6835d8a372ed9a16efb5919ef7b821957a
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="atk, gdk-pixbuf, glib, gtk3, harfbuzz, libcairo, libexif, libice, libnotify, libsm, libx11, libxml2, mate-desktop, pango, zlib"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner"
NEOTERM_PKG_DISABLE_GIR=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-xmp
--disable-packagekit
--disable-schemas-compile
--enable-introspection
--disable-update-mimedb
--disable-icon-update
"

neoterm_step_pre_configure() {
	neoterm_setup_gir
}
