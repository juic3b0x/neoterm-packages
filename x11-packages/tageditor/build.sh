NEOTERM_PKG_HOMEPAGE=https://github.com/Martchus/tageditor
NEOTERM_PKG_DESCRIPTION="A tag editor with Qt GUI and command-line interface. Supports MP4 (iTunes), ID3, Vorbis, Opus, FLAC and Matroska"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="3.9.0"
NEOTERM_PKG_SRCURL=https://github.com/Martchus/tageditor/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=ebafac24ab7c3833a018b5848b32d9fa2cfa01cafeff1b1ec1a6e30eb7415b1b
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libc++, libc++utilities, qt5-qtbase, qt5-qtdeclarative, qtutilities, tagparser"
NEOTERM_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools, qt5-qtdeclarative-cross-tools, qt5-qttools-cross-tools"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DWEBVIEW_PROVIDER=none
"

neoterm_step_pre_configure() {
	CXXFLAGS+=" -std=c++17"
}
