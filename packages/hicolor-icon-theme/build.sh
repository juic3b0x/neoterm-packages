NEOTERM_PKG_HOMEPAGE=https://www.freedesktop.org/wiki/Software/icon-theme/
NEOTERM_PKG_DESCRIPTION="Freedesktop.org Hicolor icon theme"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.17
NEOTERM_PKG_REVISION=28
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_SKIP_SRC_EXTRACT=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_AUTO_UPDATE=false # No src url to update from.

neoterm_step_make_install() {
	install -Dm644 "${NEOTERM_PKG_BUILDER_DIR}/index.theme" "${NEOTERM_PREFIX}/share/icons/hicolor/index.theme"
}
