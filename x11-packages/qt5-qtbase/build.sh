NEOTERM_PKG_HOMEPAGE=https://www.qt.io/
NEOTERM_PKG_DESCRIPTION="A cross-platform application and UI framework"
NEOTERM_PKG_LICENSE="LGPL-3.0"
NEOTERM_PKG_MAINTAINER="Simeon Huang <symeon@librehat.com>"
NEOTERM_PKG_VERSION=5.15.10
NEOTERM_PKG_REVISION=4
NEOTERM_PKG_SRCURL="https://download.qt.io/official_releases/qt/5.15/${NEOTERM_PKG_VERSION}/submodules/qtbase-everywhere-opensource-src-${NEOTERM_PKG_VERSION}.tar.xz"
NEOTERM_PKG_SHA256=c0d06cb18d20f10bf7ad53552099e097ec39362d30a5d6f104724f55fa1c8fb9
NEOTERM_PKG_DEPENDS="dbus, double-conversion, freetype, glib, harfbuzz, krb5, libandroid-execinfo, libandroid-shmem, libandroid-posix-semaphore, libc++, libice, libicu, libjpeg-turbo, libpng, libsm, libuuid, libx11, libxcb, libxi, libxkbcommon, openssl, pcre2, postgresql, ttf-dejavu, xcb-util-image, xcb-util-keysyms, xcb-util-renderutil, xcb-util-wm, zlib"
# gtk3 dependency is a run-time dependency only for the gtk platformtheme subpackage
NEOTERM_PKG_BUILD_DEPENDS="gtk3"
NEOTERM_PKG_SUGGESTS="qt5-qmake"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_NO_STATICSPLIT=true

NEOTERM_PKG_RM_AFTER_INSTALL="
bin/fixqt4headers.pl
bin/syncqt.pl
"

# Replacing the old qt5-base packages
NEOTERM_PKG_REPLACES="qt5-base"
NEOTERM_PKG_BREAKS="qt5-x11extras, qt5-tools, qt5-declarative"

neoterm_step_pre_configure () {
    if [ "${NEOTERM_ARCH}" = "arm" ]; then
        ## -mfpu=neon causes build failure on ARM.
        CFLAGS="${CFLAGS/-mfpu=neon/} -mfpu=vfp"
        CXXFLAGS="${CXXFLAGS/-mfpu=neon/} -mfpu=vfp"
    fi

    # This is needed for some packages depends on qt5-qtbase, such
    # as qt5-qtwebengine
    # https://github.com/neoterm/neoterm-packages/issues/18810
    export LDFLAGS+=" -Wl,--undefined-version"

    ## Create qmake.conf suitable for cross-compiling.
    sed \
        -e "s|@NEOTERM_PREFIX@|${NEOTERM_PREFIX}|g" \
        -e "s|@NEOTERM_CC@|${NEOTERM_HOST_PLATFORM}-clang|" \
        -e "s|@NEOTERM_CXX@|${NEOTERM_HOST_PLATFORM}-clang++|" \
        -e "s|@NEOTERM_AR@|llvm-ar|" \
        -e "s|@NEOTERM_NM@|llvm-nm|" \
        -e "s|@NEOTERM_OBJCOPY@|llvm-objcopy|" \
        -e "s|@NEOTERM_PKGCONFIG@|${NEOTERM_HOST_PLATFORM}-pkg-config|" \
        -e "s|@NEOTERM_STRIP@|llvm-strip|" \
        -e "s|@NEOTERM_CFLAGS@|${CPPFLAGS} ${CFLAGS}|" \
        -e "s|@NEOTERM_CXXFLAGS@|${CPPFLAGS} ${CXXFLAGS}|" \
        -e "s|@NEOTERM_LDFLAGS@|${LDFLAGS}|" \
        "${NEOTERM_PKG_BUILDER_DIR}/qmake.conf" > "${NEOTERM_PKG_SRCDIR}/mkspecs/neoterm-cross/qmake.conf"
}

neoterm_step_configure () {
    unset CC CXX LD CFLAGS LDFLAGS PKG_CONFIG_PATH

    "${NEOTERM_PKG_SRCDIR}"/configure -v \
        -opensource \
        -confirm-license \
        -release \
        -optimized-tools \
        -xplatform neoterm-cross \
        -shared \
        -no-rpath \
        -no-use-gold-linker \
        -prefix "${NEOTERM_PREFIX}" \
        -docdir "${NEOTERM_PREFIX}/share/doc/qt" \
        -archdatadir "${NEOTERM_PREFIX}/lib/qt" \
        -datadir "${NEOTERM_PREFIX}/share/qt" \
        -plugindir "${NEOTERM_PREFIX}/libexec/qt" \
        -hostbindir "${NEOTERM_PREFIX}/opt/qt/cross/bin" \
        -hostlibdir "${NEOTERM_PREFIX}/opt/qt/cross/lib" \
        -I "${NEOTERM_PREFIX}/include" \
        -I "${NEOTERM_PREFIX}/include/glib-2.0" \
        -I "${NEOTERM_PREFIX}/lib/glib-2.0/include" \
        -I "${NEOTERM_PREFIX}/include/gio-unix-2.0" \
        -I "${NEOTERM_PREFIX}/include/cairo" \
        -I "${NEOTERM_PREFIX}/include/pango-1.0" \
        -I "${NEOTERM_PREFIX}/include/fribidi" \
        -I "${NEOTERM_PREFIX}/include/harfbuzz" \
        -I "${NEOTERM_PREFIX}/include/atk-1.0" \
        -I "${NEOTERM_PREFIX}/include/pixman-1" \
        -I "${NEOTERM_PREFIX}/include/uuid" \
        -I "${NEOTERM_PREFIX}/include/libxml2" \
        -I "${NEOTERM_PREFIX}/include/freetype2" \
        -I "${NEOTERM_PREFIX}/include/gdk-pixbuf-2.0" \
        -I "${NEOTERM_PREFIX}/include/gtk-3.0" \
        -L "${NEOTERM_PREFIX}/lib" \
        -nomake examples \
        -no-pch \
        -no-accessibility \
        -glib \
        -gtk \
        -icu \
        -system-doubleconversion \
        -system-pcre \
        -system-zlib \
        -system-freetype \
        -ssl \
        -openssl-linked \
        -no-system-proxies \
        -no-cups \
        -system-harfbuzz \
        -no-opengl \
        -no-vulkan \
        -qpa xcb \
        -no-eglfs \
        -no-gbm \
        -no-kms \
        -no-linuxfb \
        -no-libudev \
        -no-evdev \
        -no-libinput \
        -no-mtdev \
        -no-tslib \
        -xcb \
        -xcb-xlib \
        -gif \
        -system-libpng \
        -system-libjpeg \
        -system-sqlite \
        -sql-sqlite \
        -posix-ipc

}

neoterm_step_post_make_install() {
    #######################################################
    ##
    ##  Compiling necessary libraries for target.
    ##
    #######################################################
    cd "${NEOTERM_PKG_SRCDIR}/src/tools/bootstrap" && {
        make clean

        "${NEOTERM_PREFIX}/opt/qt/cross/bin/qmake" \
            -spec "${NEOTERM_PKG_SRCDIR}/mkspecs/neoterm-cross" \
            DEFINES+="QT_POSIX_IPC"

        make -j "${NEOTERM_MAKE_PROCESSES}"
        install -Dm644 ../../../lib/libQt5Bootstrap.a "${NEOTERM_PREFIX}/lib/libQt5Bootstrap.a"
        install -Dm644 ../../../lib/libQt5Bootstrap.prl "${NEOTERM_PREFIX}/lib/libQt5Bootstrap.prl"
    }
    cd "${NEOTERM_PKG_SRCDIR}/src/tools/bootstrap-dbus" && {
        # create the dbus bootstrap archieve but we don't need to install this
        make clean

        "${NEOTERM_PREFIX}/opt/qt/cross/bin/qmake" \
            -spec "${NEOTERM_PKG_SRCDIR}/mkspecs/neoterm-cross"

        make -j "${NEOTERM_MAKE_PROCESSES}"
    }

    #######################################################
    ##
    ##  Compiling necessary programs for target.
    ##
    #######################################################
    ## Note: qmake can be built only on host so it is omitted here.
    for i in moc qlalr qvkgen rcc uic qdbuscpp2xml qdbusxml2cpp; do
        cd "${NEOTERM_PKG_SRCDIR}/src/tools/${i}" && {
            make clean

            "${NEOTERM_PREFIX}/opt/qt/cross/bin/qmake" \
                -spec "${NEOTERM_PKG_SRCDIR}/mkspecs/neoterm-cross"

            ## Fix build failure on at least 'i686'.
            sed \
                -i 's@$(LINK) $(LFLAGS) -o $(TARGET) $(OBJECTS) $(OBJCOMP) $(LIBS)@$(LINK) -o $(TARGET) $(OBJECTS) $(OBJCOMP) $(LIBS) $(LFLAGS) -lz@g' \
                Makefile

            make -j "${NEOTERM_MAKE_PROCESSES}"
            install -Dm700 "../../../bin/${i}" "${NEOTERM_PREFIX}/bin/${i}"
        }
    done
    unset i

    #######################################################
    ##
    ##  Fixes & cleanup.
    ##
    #######################################################

    # Limit the scope, otherwise it'll touch other Qt files in a dirty host env
    for i in Bootstrap Concurrent Core DBus DeviceDiscoverySupport EdidSupport EventDispatcherSupport FbSupport FontDatabaseSupport Gui InputSupport Network PrintSupport ServiceSupport Sql Test ThemeSupport Widget XcbQpa XkbCommonSupport Xml Zlib; do
        ## Drop QMAKE_PRL_BUILD_DIR because reference the build dir.
        find "${NEOTERM_PREFIX}/lib" -type f -name "libQt5${i}.prl" \
            -exec sed -i -e '/^QMAKE_PRL_BUILD_DIR/d' "{}" \;
    done
    unset i
    sed -i -e '/^QMAKE_PRL_BUILD_DIR/d' "${NEOTERM_PREFIX}/opt/qt/cross/lib/libQt5Bootstrap.prl"

    ## Remove *.la files.
    find "${NEOTERM_PREFIX}/lib" -iname \*.la -delete
    find "${NEOTERM_PREFIX}/opt/qt/cross/lib" -iname \*.la -delete

    ## Create qmake.conf suitable for compiling host tools (for other modules)
    install -Dm644 \
        "${NEOTERM_PKG_BUILDER_DIR}/qplatformdefs.host.h" \
        "${NEOTERM_PREFIX}/lib/qt/mkspecs/neoterm-host/qplatformdefs.h"
    sed \
        -e "s|@NEOTERM_PREFIX@|${NEOTERM_PREFIX}|g" \
        "${NEOTERM_PKG_BUILDER_DIR}/qmake.host.conf" > "${NEOTERM_PREFIX}/lib/qt/mkspecs/neoterm-host/qmake.conf"
}

neoterm_step_create_debscripts() {
    # Some clean-up is happening via `postinst`
    # Because we're using this package in both host (Ubuntu glibc) and device (NeoTerm)
    cp -f "${NEOTERM_PKG_BUILDER_DIR}/postinst" ./
    sed -i "s|@NEOTERM_PREFIX@|$NEOTERM_PREFIX|g" ./postinst
}
