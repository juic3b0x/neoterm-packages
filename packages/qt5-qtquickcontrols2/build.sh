NEOTERM_PKG_HOMEPAGE=https://www.qt.io/
NEOTERM_PKG_DESCRIPTION="Qt Quick Controls2 module"
NEOTERM_PKG_LICENSE="LGPL-3.0"
NEOTERM_PKG_MAINTAINER="Simeon Huang <symeon@librehat.com>"
NEOTERM_PKG_VERSION=5.15.10
NEOTERM_PKG_SRCURL="https://download.qt.io/official_releases/qt/5.15/${NEOTERM_PKG_VERSION}/submodules/qtquickcontrols2-everywhere-opensource-src-${NEOTERM_PKG_VERSION}.tar.xz"
NEOTERM_PKG_SHA256=97954c92fee9031ec31341812ccf53afb3c132e2b271bcef1174367fa002fc8e
NEOTERM_PKG_DEPENDS="libc++, qt5-qtbase, qt5-qtdeclarative"
NEOTERM_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_NO_STATICSPLIT=true

neoterm_step_configure () {
    "${NEOTERM_PREFIX}/opt/qt/cross/bin/qmake" \
        -spec "${NEOTERM_PREFIX}/lib/qt/mkspecs/neoterm-cross"
}

neoterm_step_post_make_install() {
    #######################################################
    ##
    ##  Fixes & cleanup.
    ##
    #######################################################

    ## Drop QMAKE_PRL_BUILD_DIR because reference the build dir.
    find "${NEOTERM_PREFIX}/lib" -type f -name "libQt5QuickControls2*.prl" \
        -exec sed -i -e '/^QMAKE_PRL_BUILD_DIR/d' "{}" \;
    find "${NEOTERM_PREFIX}/lib" -type f -name "libQt5QuickTemplates2*.prl" \
        -exec sed -i -e '/^QMAKE_PRL_BUILD_DIR/d' "{}" \;

    ## Remove *.la files.
    find "${NEOTERM_PREFIX}/lib" -iname \*.la -delete
}

