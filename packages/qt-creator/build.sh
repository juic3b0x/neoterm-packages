NEOTERM_PKG_HOMEPAGE=https://www.qt.io/
NEOTERM_PKG_DESCRIPTION="Integrated Development Environment for Qt"
NEOTERM_PKG_LICENSE="LGPL-3.0"
NEOTERM_PKG_MAINTAINER="Simeon Huang <symeon@librehat.com>"
NEOTERM_PKG_VERSION=4.15.2
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL="https://github.com/qt-creator/qt-creator/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz"
NEOTERM_PKG_SHA256=e23e76ea518cc65949f29e9eff18331a9a1da0817b292afbcbb4d5cdeada3c47
NEOTERM_PKG_AUTO_UPDATE=false
NEOTERM_PKG_DEPENDS="libc++, qt5-qtbase, qt5-qtdeclarative, qt5-qtxmlpatterns, qt5-qttools, qt5-qtx11extras, qt5-qtsvg, llvm, clang"
NEOTERM_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools, qt5-qtdeclarative-cross-tools, qt5-qttools-cross-tools"
NEOTERM_PKG_RECOMMENDS="gdb, git, make, cmake, valgrind"
NEOTERM_PKG_SUGGESTS="cvs, subversion"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_NO_STATICSPLIT=true

neoterm_step_configure () {
    # -r to force Makefile generations for all subdirs at this step so process_stub can be patched
    # Disable QML Designer plugin which requires OpenGL
    # Disable clang refactoring plugin which has odd linking issues at the moment
    export QTC_DO_NOT_BUILD_QMLDESIGNER=1
    export QTC_DISABLE_CLANG_REFACTORING=1
    "${NEOTERM_PREFIX}/opt/qt/cross/bin/qmake" -r \
        -spec "${NEOTERM_PREFIX}/lib/qt/mkspecs/neoterm-cross"
}

neoterm_step_post_configure() {
    # process_stub's Makefile has the incorrect LINK executable (it should've been QMAKE_CXX)
    sed -i "s|^LINK          = clang|LINK = ${CXX}|" \
        ${NEOTERM_PKG_SRCDIR}/src/libs/utils/Makefile.process_stub

    # clangbackend's Makefile lacks -lc++_shared to link against libc++ on x86_64
    sed -i -e 's|^LIBS          = $(SUBLIBS)|LIBS = $(SUBLIBS) -lc++_shared|' \
	-e 's|-Wl,-rpath,'${NEOTERM_COMMON_CACHEDIR//./\\.}'/android-r[0-9][^/]*/lib64||g' \
	-e 's|-L'${NEOTERM_COMMON_CACHEDIR//./\\.}'/android-r[0-9][^/]*/lib64||g' \
        ${NEOTERM_PKG_SRCDIR}/src/tools/clangbackend/Makefile

    # make sure clangtools link against libc++_shared on x86_64
    sed -i -e 's|^LIBS          = $(SUBLIBS)|LIBS = $(SUBLIBS) -lc++_shared|' \
	-e 's|-Wl,-rpath,'${NEOTERM_COMMON_CACHEDIR//./\\.}'/android-r[0-9][^/]*/lib64||g' \
	-e 's|-L'${NEOTERM_COMMON_CACHEDIR//./\\.}'/android-r[0-9][^/]*/lib64||g' \
        ${NEOTERM_PKG_SRCDIR}/src/plugins/clangtools/Makefile

    # required by make install, otherwise it installs to '/'
    export INSTALL_ROOT="${NEOTERM_PREFIX}"
}
