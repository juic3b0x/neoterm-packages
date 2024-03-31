NEOTERM_PKG_HOMEPAGE=https://www.qt.io/
NEOTERM_PKG_DESCRIPTION="Qt Serial Port Library"
NEOTERM_PKG_LICENSE="LGPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=5.15.10
NEOTERM_PKG_SRCURL="https://download.qt.io/official_releases/qt/5.15/${NEOTERM_PKG_VERSION}/submodules/qtserialport-everywhere-opensource-src-${NEOTERM_PKG_VERSION}.tar.xz"
NEOTERM_PKG_SHA256=fc6f4e2a4585dd24898c3a823ab82f05f7337c0e0fd710bbde7745bc80f068fe
NEOTERM_PKG_DEPENDS="libc++, qt5-qtbase"
NEOTERM_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_NO_STATICSPLIT=true

neoterm_step_configure () {
	"${NEOTERM_PREFIX}/opt/qt/cross/bin/qmake" \
		-spec "${NEOTERM_PREFIX}/lib/qt/mkspecs/neoterm-cross"
}

neoterm_step_make_install() {
	make install

	#######################################################
	##
	##  Fixes & cleanup.
	##
	#######################################################

	## Drop QMAKE_PRL_BUILD_DIR because reference the build dir.
	find "${NEOTERM_PREFIX}/lib" -type f -name "libQt5SerialPort*.prl" \
		-exec sed -i -e '/^QMAKE_PRL_BUILD_DIR/d' "{}" \;

	## Remove *.la files.
	find "${NEOTERM_PREFIX}/lib" -iname \*.la -delete
}
