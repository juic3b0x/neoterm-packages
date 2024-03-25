NEOTERM_PKG_HOMEPAGE=https://github.com/AyatanaIndicators/ayatana-ido
NEOTERM_PKG_DESCRIPTION="Ayatana Indicator Display Objects"
NEOTERM_PKG_LICENSE="LGPL-2.1, LGPL-3.0, GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.10.1"
NEOTERM_PKG_SRCURL=https://github.com/AyatanaIndicators/ayatana-ido/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=26187915a6f3402195e2c78d9e8a54549112a3cd05bb2fbe2059d3e78fc0e071
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_DEPENDS="gdk-pixbuf, glib, gtk3, libcairo, pango"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner, valac"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DENABLE_TESTS=OFF
"

neoterm_step_pre_configure() {
	NEOTERM_PKG_VERSION=. neoterm_setup_gir
}
