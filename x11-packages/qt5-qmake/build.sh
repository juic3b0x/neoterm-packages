NEOTERM_PKG_HOMEPAGE=https://www.qt.io/
NEOTERM_PKG_DESCRIPTION="Qt 5 QMake"
NEOTERM_PKG_LICENSE="LGPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=5.15.5
NEOTERM_PKG_SRCURL="https://download.qt.io/official_releases/qt/5.15/${NEOTERM_PKG_VERSION}/submodules/qtbase-everywhere-opensource-src-${NEOTERM_PKG_VERSION}.tar.xz"
# NEOTERM_PKG_SHA256 is not used in neoterm-build-qmake.sh.
NEOTERM_PKG_SHA256=SKIP_CHECKSUM
NEOTERM_PKG_SKIP_SRC_EXTRACT=true
NEOTERM_PKG_DEPENDS="qt5-qtbase"
NEOTERM_PKG_BREAKS="qt5-qtbase (<< 5.15.7)"
NEOTERM_PKG_REPLACES="qt5-qtbase (<< 5.15.7)"

neoterm_step_make_install() {
	## Unpacking prebuilt qmake from archive.
	cd "${NEOTERM_PKG_SRCDIR}" && {
		tar xf "${NEOTERM_PKG_BUILDER_DIR}/prebuilt.tar.xz"
		install \
			-Dm700 "${NEOTERM_PKG_SRCDIR}/bin/qmake-${NEOTERM_HOST_PLATFORM}" \
			"${NEOTERM_PREFIX}/bin/qmake"
	}
}
