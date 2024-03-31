NEOTERM_PKG_HOMEPAGE=https://fritzing.org/
NEOTERM_PKG_DESCRIPTION="An Electronic Design Automation software"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.9.6
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://github.com/fritzing/fritzing-app/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=eb4ebe461c5d42edb4b10f1f824e7c855ad54555e222c5999061dead09834491
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_DEPENDS="fritzing-data, libc++, libgit2, qt5-qtbase, qt5-qtserialport, qt5-qtsvg, quazip"
NEOTERM_PKG_BUILD_DEPENDS="boost, boost-headers, qt5-qtbase-cross-tools"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
PREFIX=$NEOTERM_PREFIX
PKG_CONFIG=pkg-config
DEFINES=QUAZIP_INSTALLED
"

neoterm_step_post_get_source() {
	rm -rf src/lib/quazip pri/quazip.pri
}

neoterm_step_configure() {
	"${NEOTERM_PREFIX}/opt/qt/cross/bin/qmake" \
		-spec "${NEOTERM_PREFIX}/lib/qt/mkspecs/neoterm-cross" \
		${NEOTERM_PKG_EXTRA_CONFIGURE_ARGS}
}
