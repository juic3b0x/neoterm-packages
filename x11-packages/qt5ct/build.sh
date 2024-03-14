NEOTERM_PKG_HOMEPAGE=https://sourceforge.net/projects/qt5ct
NEOTERM_PKG_DESCRIPTION="Qt5 Configuration Tool"
NEOTERM_PKG_LICENSE="BSD 2-Clause"
NEOTERM_PKG_MAINTAINER="Simeon Huang <symeon@librehat.com>"
NEOTERM_PKG_VERSION="1.8"
NEOTERM_PKG_SRCURL="https://downloads.sf.net/qt5ct/qt5ct-${NEOTERM_PKG_VERSION}.tar.bz2"
NEOTERM_PKG_SHA256=23b74054415ea4124328772ef9a6f95083a9b86569e128034a3ff75dfad808e9
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libc++, qt5-qtbase"
NEOTERM_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools, qt5-qttools-cross-tools"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_NO_STATICSPLIT=true

neoterm_step_configure () {
    "${NEOTERM_PREFIX}/opt/qt/cross/bin/qmake" \
        -spec "${NEOTERM_PREFIX}/lib/qt/mkspecs/neoterm-cross" \
        PREFIX="${NEOTERM_PREFIX}"
}
