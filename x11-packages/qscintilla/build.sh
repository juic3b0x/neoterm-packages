NEOTERM_PKG_HOMEPAGE=https://riverbankcomputing.com/software/qscintilla
NEOTERM_PKG_DESCRIPTION="QScintilla is a port to Qt of the Scintilla editing component"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="Simeon Huang <symeon@librehat.com>"
# Align the version with `python-qscintilla` package.
NEOTERM_PKG_VERSION=2.14.1
NEOTERM_PKG_SRCURL="https://www.riverbankcomputing.com/static/Downloads/QScintilla/${NEOTERM_PKG_VERSION}/QScintilla_src-${NEOTERM_PKG_VERSION}.tar.gz"
NEOTERM_PKG_SHA256=dfe13c6acc9d85dfcba76ccc8061e71a223957a6c02f3c343b30a9d43a4cdd4d
NEOTERM_PKG_DEPENDS="libc++, qt5-qtbase"
# qttools is only needed to build Qt Designer's plugins
NEOTERM_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools, qt5-qttools"
NEOTERM_PKG_BREAKS="python-qscintilla (<< ${NEOTERM_PKG_VERSION})"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_NO_STATICSPLIT=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="-C src"

neoterm_step_configure () {
    for i in src designer; do
        cd "${NEOTERM_PKG_SRCDIR}/${i}" && {
            "${NEOTERM_PREFIX}/opt/qt/cross/bin/qmake" \
                -spec "${NEOTERM_PREFIX}/lib/qt/mkspecs/neoterm-cross"
        }
    done
    unset i
}

neoterm_step_post_make_install() {
    cd "${NEOTERM_PKG_SRCDIR}/designer" && {
        make -j "${NEOTERM_MAKE_PROCESSES}"
        make install
    }
}

