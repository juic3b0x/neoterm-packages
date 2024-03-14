# x11-packages
NEOTERM_PKG_HOMEPAGE=https://github.com/midori-browser/core
NEOTERM_PKG_DESCRIPTION="A lightweight, fast and free web browser using WebKit and GTK+"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=9.0
NEOTERM_PKG_SRCURL=https://github.com/midori-browser/core/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=913a7cba95ddcc3dc5f6b12d861e765d6fa990fe7d4efc3768d3a3567ea460db
NEOTERM_PKG_DEPENDS="gcr, gdk-pixbuf, glib, gtk3, json-glib, libarchive, libcairo, libpeas, libsoup, libsqlite, webkit2gtk"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner"

neoterm_step_pre_configure() {
	neoterm_setup_gir
}
