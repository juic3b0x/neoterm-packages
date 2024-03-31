NEOTERM_PKG_HOMEPAGE=https://github.com/AyatanaIndicators/libayatana-appindicator
NEOTERM_PKG_DESCRIPTION="Ayatana Application Indicators"
NEOTERM_PKG_LICENSE="GPL-3.0, LGPL-2.1, LGPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.5.93"
NEOTERM_PKG_SRCURL=https://github.com/AyatanaIndicators/libayatana-appindicator/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=cbefed7a918a227bf71286246e237fcd3a9c8499b3eaac4897811a869409edf0
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_DEPENDS="glib, gtk3, libayatana-indicator, libdbusmenu, libdbusmenu-gtk3"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner, valac"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DENABLE_BINDINGS_MONO=OFF
-DENABLE_GTKDOC=OFF
"

neoterm_step_pre_configure() {
	NEOTERM_PKG_VERSION=. neoterm_setup_gir
}
