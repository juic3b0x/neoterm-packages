NEOTERM_PKG_HOMEPAGE=https://www.qt.io/
NEOTERM_PKG_DESCRIPTION="Qt 5 Multimedia Library"
NEOTERM_PKG_LICENSE="LGPL-3.0"
NEOTERM_PKG_MAINTAINER="Simeon Huang <symeon@librehat.com>"
NEOTERM_PKG_VERSION=5.15.10
NEOTERM_PKG_SRCURL="https://download.qt.io/official_releases/qt/5.15/${NEOTERM_PKG_VERSION}/submodules/qtmultimedia-everywhere-opensource-src-${NEOTERM_PKG_VERSION}.tar.xz"
NEOTERM_PKG_SHA256=1106e0bd8ec65b2c0a89170e452ea104ca9431050f507da5e874be2cb54f29b6
# qt5-qtdeclarative is not needed because quick widget requires OpenGL
NEOTERM_PKG_DEPENDS="libc++, qt5-qtbase, pulseaudio, openal-soft, gstreamer, gst-plugins-base, gst-plugins-bad"
NEOTERM_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_NO_STATICSPLIT=true

neoterm_step_configure () {
    "${NEOTERM_PREFIX}/opt/qt/cross/bin/qmake" \
        -spec "${NEOTERM_PREFIX}/lib/qt/mkspecs/neoterm-cross" \
        GST_VERSION=1.0 \
        INCLUDEPATH+="${NEOTERM_PREFIX}/include/gstreamer-1.0/" \
        INCLUDEPATH+="${NEOTERM_PREFIX}/include/glib-2.0/" \
        INCLUDEPATH+="${NEOTERM_PREFIX}/lib/glib-2.0/include"
}

neoterm_step_make_install() {
    make install

    #######################################################
    ##
    ##  Fixes & cleanup.
    ##
    #######################################################

    ## Drop QMAKE_PRL_BUILD_DIR because reference the build dir.
    find "${NEOTERM_PREFIX}/lib" -type f -name "libQt5Multimedia*.prl" \
        -exec sed -i -e '/^QMAKE_PRL_BUILD_DIR/d' "{}" \;

    ## Remove *.la files.
    find "${NEOTERM_PREFIX}/lib" -iname \*.la -delete
}

