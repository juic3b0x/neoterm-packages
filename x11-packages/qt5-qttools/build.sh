NEOTERM_PKG_HOMEPAGE=https://www.qt.io/
NEOTERM_PKG_DESCRIPTION="Qt Development Tools (Linguist, Assistant, Designer, etc.)"
NEOTERM_PKG_LICENSE="LGPL-3.0"
NEOTERM_PKG_MAINTAINER="Simeon Huang <symeon@librehat.com>"
NEOTERM_PKG_VERSION=5.15.10
NEOTERM_PKG_SRCURL="https://download.qt.io/official_releases/qt/5.15/${NEOTERM_PKG_VERSION}/submodules/qttools-everywhere-opensource-src-${NEOTERM_PKG_VERSION}.tar.xz"
NEOTERM_PKG_SHA256=66f46c9729c831dce431778a9c561cca32daceaede1c7e58568d7a5898167dae
NEOTERM_PKG_DEPENDS="libc++, qt5-qtbase, qt5-qtdeclarative"
NEOTERM_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools, qt5-qtdeclarative-cross-tools"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_NO_STATICSPLIT=true

# Ignore the bootstrap library that is touched by the hijack
NEOTERM_PKG_RM_AFTER_INSTALL="
opt/qt/cross/lib/libQt5Bootstrap.*
opt/qt/cross/lib/libQt5QmlDevTools.*
"

# Replacing the old qt5-base packages
NEOTERM_PKG_REPLACES="qt5-tools"

neoterm_step_pre_configure () {
    #######################################################
    ##
    ##  Hijack the bootstrap library
    ##
    #######################################################
    for i in Bootstrap QmlDevTools; do
        cp -p "${NEOTERM_PREFIX}/opt/qt/cross/lib/libQt5${i}.a" \
            "${NEOTERM_PREFIX}/opt/qt/cross/lib/libQt5${i}.a.bak"
        ln -s -f "${NEOTERM_PREFIX}/lib/libQt5${i}.a" \
            "${NEOTERM_PREFIX}/opt/qt/cross/lib/libQt5${i}.a"
        cp -p "${NEOTERM_PREFIX}/opt/qt/cross/lib/libQt5${i}.prl" \
            "${NEOTERM_PREFIX}/opt/qt/cross/lib/libQt5${i}.prl.bak"
        ln -s -f "${NEOTERM_PREFIX}/lib/libQt5${i}.prl" \
            "${NEOTERM_PREFIX}/opt/qt/cross/lib/libQt5${i}.prl"
    done
    unset i
}

neoterm_step_configure () {
    "${NEOTERM_PREFIX}/opt/qt/cross/bin/qmake" \
        -spec "${NEOTERM_PREFIX}/lib/qt/mkspecs/neoterm-cross"
}

neoterm_step_post_make_install() {
    #######################################################
    ##
    ##  Compiling necessary programs for target.
    ##
    #######################################################

    ## Some top-level tools
    # FIXME: qdoc cannot be built at the moment because qmake couldn't find libclang when built with -I
    for i in makeqpf pixeltool qev qtattributionsscanner; do
        cd "${NEOTERM_PKG_SRCDIR}/src/${i}" && {
            "${NEOTERM_PREFIX}/opt/qt/cross/bin/qmake" \
                -spec "${NEOTERM_PREFIX}/lib/qt/mkspecs/neoterm-cross"

            make -j "${NEOTERM_MAKE_PROCESSES}"
            install -Dm700 "../../bin/${i}" "${NEOTERM_PREFIX}/bin/${i}"
        }
    done
    unset i

    # QDbusViewer desktop file (the binary would be installed already)
    install -D -m644 \
        "${NEOTERM_PKG_SRCDIR}/src/qdbus/qdbusviewer/images/qdbusviewer.png" \
        "${NEOTERM_PREFIX}/share/icons/hicolor/32x32/apps/qdbusviewer.png"
    install -D -m644 \
        "${NEOTERM_PKG_SRCDIR}/src/qdbus/qdbusviewer/images/qdbusviewer-128.png" \
        "${NEOTERM_PREFIX}/share/icons/hicolor/128x128/apps/qdbusviewer.png"
    install -D -m644 \
        "${NEOTERM_PKG_BUILDER_DIR}/qdbusviewer.desktop" \
        "${NEOTERM_PREFIX}/share/applications/qdbusviewer.desktop"

    # qdistancefieldgenerator (it has a different directory name but supports make install)
    cd "${NEOTERM_PKG_SRCDIR}/src/distancefieldgenerator" && {
        "${NEOTERM_PREFIX}/opt/qt/cross/bin/qmake" \
            -spec "${NEOTERM_PREFIX}/lib/qt/mkspecs/neoterm-cross"

        make -j "${NEOTERM_MAKE_PROCESSES}"
        make install
    }

    #######################################################
    ##
    ##  Qt Linguist
    ##
    #######################################################

    # Install the linguist utilities to the correct path
    for i in lconvert lprodump lrelease{,-pro} lupdate{,-pro}; do
        install -Dm700 "${NEOTERM_PKG_SRCDIR}/bin/${i}" "${NEOTERM_PREFIX}/bin/${i}"
    done

    # Build and install linguist program
    cd "${NEOTERM_PKG_SRCDIR}/src/linguist/linguist" && {
        "${NEOTERM_PREFIX}/opt/qt/cross/bin/qmake" \
            -spec "${NEOTERM_PREFIX}/lib/qt/mkspecs/neoterm-cross"
        make -j "${NEOTERM_MAKE_PROCESSES}"
        make install
    }

    # Install the linguist desktop file
    install -Dm644 \
        "${NEOTERM_PKG_SRCDIR}/src/linguist/linguist/images/icons/linguist-32-32.png" \
        "${NEOTERM_PREFIX}/share/icons/hicolor/32x32/apps/linguist.png"
    install -Dm644 \
        "${NEOTERM_PKG_SRCDIR}/src/linguist/linguist/images/icons/linguist-128-32.png" \
        "${NEOTERM_PREFIX}/share/icons/hicolor/128x128/apps/linguist.png"
    install -Dm644 \
        "${NEOTERM_PKG_BUILDER_DIR}/linguist.desktop" \
        "${NEOTERM_PREFIX}/share/applications/linguist.desktop"

    #######################################################
    ##
    ##  Qt Assistant
    ##
    #######################################################

    for i in qcollectiongenerator qhelpgenerator assistant; do
        cd "${NEOTERM_PKG_SRCDIR}/src/assistant/${i}" && {
            "${NEOTERM_PREFIX}/opt/qt/cross/bin/qmake" \
                -spec "${NEOTERM_PREFIX}/lib/qt/mkspecs/neoterm-cross"

            make -j "${NEOTERM_MAKE_PROCESSES}"
            install -Dm700 "../../../bin/${i}" "${NEOTERM_PREFIX}/bin/${i}"
        }
    done

    install -Dm644 \
        "${NEOTERM_PKG_SRCDIR}/src/assistant/assistant/images/assistant.png" \
        "${NEOTERM_PREFIX}/share/icons/hicolor/32x32/apps/assistant.png"
    install -Dm644 \
        "${NEOTERM_PKG_SRCDIR}/src/assistant/assistant/images/assistant-128.png" \
        "${NEOTERM_PREFIX}/share/icons/hicolor/128x128/apps/assistant.png"
    install -Dm644 \
        "${NEOTERM_PKG_BUILDER_DIR}/assistant.desktop" \
        "${NEOTERM_PREFIX}/share/applications/assistant.desktop"


    #######################################################
    ##
    ##  Qt Designer
    ##
    #######################################################

    for i in lib components designer plugins; do
        cd "${NEOTERM_PKG_SRCDIR}/src/designer/src/${i}" && {
            "${NEOTERM_PREFIX}/opt/qt/cross/bin/qmake" \
                -spec "${NEOTERM_PREFIX}/lib/qt/mkspecs/neoterm-cross"

            make -j "${NEOTERM_MAKE_PROCESSES}"
            make install
        }
    done

    install -Dm644 \
        "${NEOTERM_PKG_SRCDIR}/src/designer/src/designer/images/designer.png" \
        "${NEOTERM_PREFIX}/share/icons/hicolor/128x128/apps/designer.png"
    install -Dm644 \
        "${NEOTERM_PKG_BUILDER_DIR}/designer.desktop" \
        "${NEOTERM_PREFIX}/share/applications/designer.desktop"


    #######################################################
    ##
    ##  Restore the bootstrap library
    ##
    #######################################################
    for i in Bootstrap QmlDevTools; do
        mv "${NEOTERM_PREFIX}/opt/qt/cross/lib/libQt5${i}.a.bak" \
            "${NEOTERM_PREFIX}/opt/qt/cross/lib/libQt5${i}.a"
        mv "${NEOTERM_PREFIX}/opt/qt/cross/lib/libQt5${i}.prl.bak" \
            "${NEOTERM_PREFIX}/opt/qt/cross/lib/libQt5${i}.prl"
    done


    #######################################################
    ##
    ##  Compiling necessary programs for host
    ##
    #######################################################

    # These programs were built and linked for the target
    # We need to build them again but for the host
    cd "${NEOTERM_PKG_SRCDIR}/src/qtattributionsscanner" && {
        make clean
        "${NEOTERM_PREFIX}/opt/qt/cross/bin/qmake" \
            -spec "${NEOTERM_PREFIX}/lib/qt/mkspecs/neoterm-host"
        make -j "${NEOTERM_MAKE_PROCESSES}"
        install -Dm700 \
            "../../bin/qtattributionsscanner" \
            "${NEOTERM_PREFIX}/opt/qt/cross/bin/qtattributionsscanner"
    }

    for i in lconvert lprodump lrelease{,-pro} lupdate{,-pro}; do
        cd "${NEOTERM_PKG_SRCDIR}/src/linguist/${i}" && {
            make clean
            "${NEOTERM_PREFIX}/opt/qt/cross/bin/qmake" \
                -spec "${NEOTERM_PREFIX}/lib/qt/mkspecs/neoterm-host"
            make -j "${NEOTERM_MAKE_PROCESSES}"
            install -Dm700 "../../../bin/${i}" "${NEOTERM_PREFIX}/opt/qt/cross/bin/${i}"
        }
    done

    #######################################################
    ##
    ##  Fixes & cleanup.
    ##
    #######################################################

    # Limit the scope, otherwise it'll touch qtbase files
    for pref in Designer Help UiTools UiPlugin; do
        ## Drop QMAKE_PRL_BUILD_DIR because reference the build dir.
        find "${NEOTERM_PREFIX}/lib" -type f -name "libQt5${pref}*.prl" \
            -exec sed -i -e '/^QMAKE_PRL_BUILD_DIR/d' "{}" \;
    done
    unset pref

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
