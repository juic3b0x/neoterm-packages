NEOTERM_PKG_HOMEPAGE=https://github.com/tibirna/qgit
NEOTERM_PKG_DESCRIPTION="A git GUI viewer"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.10"
NEOTERM_PKG_SRCURL=https://github.com/tibirna/qgit/archive/qgit-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=1fc74fbd25c8ccbee9f7d4a8817b0a82ffa5a3a281b324febe4e90ea7c721153
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_SED_REGEXP='s/.*-//'
NEOTERM_PKG_DEPENDS="git, libc++, qt5-qtbase"
NEOTERM_PKG_RECOMMENDS="hicolor-icon-theme"
NEOTERM_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_configure() {
	"${NEOTERM_PREFIX}/opt/qt/cross/bin/qmake" \
		-spec "${NEOTERM_PREFIX}/lib/qt/mkspecs/neoterm-cross"
}
