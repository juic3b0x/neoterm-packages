NEOTERM_PKG_HOMEPAGE=https://www.texstudio.org/
NEOTERM_PKG_DESCRIPTION="A fully featured LaTeX editor"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="4.7.3"
NEOTERM_PKG_SRCURL=https://github.com/texstudio-org/texstudio/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=57760be0c0855b79f98a6aa32c9839509fb64f4763790d06548109071cc00772
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="hunspell, libc++, libx11, poppler-qt, qt5-qtbase, qt5-qtdeclarative, qt5-qtsvg, qt5-qttools, quazip, texstudio-data, zlib"
NEOTERM_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools, qt5-qtdeclarative-cross-tools, qt5-qttools-cross-tools"
NEOTERM_PKG_RECOMMENDS="ghostscript"
NEOTERM_PKG_SUGGESTS="texlive-installer"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
PKG_CONFIG=pkg-config
PREFIX=$NEOTERM_PREFIX
USE_SYSTEM_HUNSPELL=1
USE_SYSTEM_QUAZIP=1
"

neoterm_step_configure() {
	"${NEOTERM_PREFIX}/opt/qt/cross/bin/qmake" \
		-spec "${NEOTERM_PREFIX}/lib/qt/mkspecs/neoterm-cross" \
		${NEOTERM_PKG_EXTRA_CONFIGURE_ARGS}
}
