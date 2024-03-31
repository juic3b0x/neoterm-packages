NEOTERM_PKG_HOMEPAGE=https://www.qt.io/
NEOTERM_PKG_DESCRIPTION="The Qt Declarative module provides classes for using GUIs created using QML"
NEOTERM_PKG_LICENSE="LGPL-3.0"
NEOTERM_PKG_MAINTAINER="Simeon Huang <symeon@librehat.com>"
NEOTERM_PKG_VERSION=5.15.10
NEOTERM_PKG_SRCURL="https://download.qt.io/official_releases/qt/5.15/${NEOTERM_PKG_VERSION}/submodules/qtdeclarative-everywhere-opensource-src-${NEOTERM_PKG_VERSION}.tar.xz"
NEOTERM_PKG_SHA256=239b4c3c4cc49b174391445ad4b8320c11c8655300977955febd5dde69d33df4
NEOTERM_PKG_DEPENDS="libc++, qt5-qtbase"
NEOTERM_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_NO_STATICSPLIT=true

# Ignore bootstrap changes because of the hijacking
NEOTERM_PKG_RM_AFTER_INSTALL="
opt/qt/cross/lib/libQt5Bootstrap.*
"

# Replacing the old qt5-base packages
NEOTERM_PKG_REPLACES="qt5-declarative"

neoterm_step_pre_configure () {
    pushd "${NEOTERM_PKG_SRCDIR}/src/qmltyperegistrar"
    "${NEOTERM_PREFIX}/opt/qt/cross/bin/qmake" \
        -spec "${NEOTERM_PREFIX}/lib/qt/mkspecs/neoterm-host"
    make -j "${NEOTERM_MAKE_PROCESSES}"
    popd

    #######################################################
    ##
    ##  Hijack the bootstrap library for cross building
    ##
    #######################################################
    for i in a prl; do
        cp -p "${NEOTERM_PREFIX}/opt/qt/cross/lib/libQt5Bootstrap.${i}" \
            "${NEOTERM_PREFIX}/opt/qt/cross/lib/libQt5Bootstrap.${i}.bak"
        ln -s -f "${NEOTERM_PREFIX}/lib/libQt5Bootstrap.${i}" \
            "${NEOTERM_PREFIX}/opt/qt/cross/lib/libQt5Bootstrap.${i}"
    done
    unset i
}

neoterm_step_configure () {
    "${NEOTERM_PREFIX}/opt/qt/cross/bin/qmake" \
        -spec "${NEOTERM_PREFIX}/lib/qt/mkspecs/neoterm-cross"
}

neoterm_step_post_make_install () {
    #######################################################
    ##
    ##  Compiling necessary binaries for target.
    ##
    #######################################################

    ## Qt Declarative utilities.
    for i in qmlcachegen qmlformat qmlimportscanner qmllint qmlmin; do
        cd "${NEOTERM_PKG_SRCDIR}/tools/${i}" && {
            "${NEOTERM_PREFIX}/opt/qt/cross/bin/qmake" \
                -spec "${NEOTERM_PREFIX}/lib/qt/mkspecs/neoterm-cross"

            make -j "${NEOTERM_MAKE_PROCESSES}"
            install -Dm700 "../../bin/${i}" "${NEOTERM_PREFIX}/bin/${i}"
        }
    done

    for i in qmltyperegistrar; do
        cd "${NEOTERM_PKG_SRCDIR}/src/${i}" && {
            make clean

            "${NEOTERM_PREFIX}/opt/qt/cross/bin/qmake" \
                -spec "${NEOTERM_PREFIX}/lib/qt/mkspecs/neoterm-cross"

            make -j "${NEOTERM_MAKE_PROCESSES}"
            install -Dm700 "../../bin/${i}" "${NEOTERM_PREFIX}/bin/${i}"
        }
    done

    # Install the QmlDevTools for target (needed by some packages such as qttools)
    install -Dm644 ${NEOTERM_PKG_SRCDIR}/lib/libQt5QmlDevTools.a "${NEOTERM_PREFIX}/lib/libQt5QmlDevTools.a"
    install -Dm644 ${NEOTERM_PKG_SRCDIR}/lib/libQt5QmlDevTools.prl "${NEOTERM_PREFIX}/lib/libQt5QmlDevTools.prl"
    sed -i 's|/opt/qt/cross/|/|g' "${NEOTERM_PREFIX}/lib/libQt5QmlDevTools.prl"

    #######################################################
    ##
    ##  Restore the bootstrap library
    ##
    #######################################################
    for i in a prl; do
        rm -f "${NEOTERM_PREFIX}/opt/qt/cross/lib/libQt5Bootstrap.${i}"
        cp -p "${NEOTERM_PREFIX}/opt/qt/cross/lib/libQt5Bootstrap.${i}.bak" \
            "${NEOTERM_PREFIX}/opt/qt/cross/lib/libQt5Bootstrap.${i}"
        rm -f "${NEOTERM_PREFIX}/opt/qt/cross/lib/libQt5Bootstrap.${i}.bak"
    done
    unset i

    #######################################################
    ##
    ##  Compiling necessary binaries for the host
    ##
    #######################################################

    ## libQt5QmlDevTools.a (qt5-declarative)
    cd "${NEOTERM_PKG_SRCDIR}/src/qmldevtools" && {
        make clean

        "${NEOTERM_PREFIX}/opt/qt/cross/bin/qmake" \
            -spec "${NEOTERM_PREFIX}/lib/qt/mkspecs/neoterm-host"

        make -j "${NEOTERM_MAKE_PROCESSES}"
        install -Dm644 ../../lib/libQt5QmlDevTools.a "${NEOTERM_PREFIX}/opt/qt/cross/lib/libQt5QmlDevTools.a"
        install -Dm644 ../../lib/libQt5QmlDevTools.prl "${NEOTERM_PREFIX}/opt/qt/cross/lib/libQt5QmlDevTools.prl"
    }

    ## Qt Declarative utilities.
    for i in qmlcachegen qmlformat qmlimportscanner qmllint qmlmin; do
        cd "${NEOTERM_PKG_SRCDIR}/tools/${i}" && {
            make clean

            "${NEOTERM_PREFIX}/opt/qt/cross/bin/qmake" \
                -spec "${NEOTERM_PREFIX}/lib/qt/mkspecs/neoterm-host"

            make -j "${NEOTERM_MAKE_PROCESSES}"
            install -Dm700 "../../bin/${i}" "${NEOTERM_PREFIX}/opt/qt/cross/bin/${i}"
        }
    done

    for i in qmltyperegistrar; do
        cd "${NEOTERM_PKG_SRCDIR}/src/${i}" && {
            make clean

            "${NEOTERM_PREFIX}/opt/qt/cross/bin/qmake" \
                -spec "${NEOTERM_PREFIX}/lib/qt/mkspecs/neoterm-host"

            make -j "${NEOTERM_MAKE_PROCESSES}"
            install -Dm700 "../../bin/${i}" "${NEOTERM_PREFIX}/opt/qt/cross/bin/${i}"
        }
    done

    #######################################################
    ##
    ##  Fixes & cleanup.
    ##
    #######################################################

    # Limit the scope, otherwise it'll touch qtbase files
    for pref in Qml Quick Packet; do
        ## Drop QMAKE_PRL_BUILD_DIR because reference the build dir.
        find "${NEOTERM_PREFIX}/lib" -type f -name "libQt5${pref}*.prl" \
            -exec sed -i -e '/^QMAKE_PRL_BUILD_DIR/d' "{}" \;
    done
    unset pref
    sed -i -e '/^QMAKE_PRL_BUILD_DIR/d' "${NEOTERM_PREFIX}/opt/qt/cross/lib/libQt5QmlDevTools.prl"

    ## Remove *.la files.
    find "${NEOTERM_PREFIX}/lib" -iname \*.la -delete
    find "${NEOTERM_PREFIX}/opt/qt/cross/lib" -iname \*.la -delete
}

neoterm_step_create_debscripts() {
    # Some clean-up is happening via `postinst`
    # Because we're using this package in both host (Ubuntu glibc) and device (NeoTerm)
    cp -f "${NEOTERM_PKG_BUILDER_DIR}/postinst" ./
    sed -i "s|@NEOTERM_PREFIX@|$NEOTERM_PREFIX|g" ./postinst
}
