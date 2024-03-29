#!/data/data/io.neoterm/files/usr/bin/bash
##
##  A script for building qmake on device.
##  Use in NeoTerm only !
##
##  Usage:
##
##  ./neoterm-build-qmake.sh

set -e

NEOTERM_PREFIX=/data/data/io.neoterm/files/usr

if [ $(uname -o) != Android ]; then
    echo "This script should be run in NeoTerm !"
    exit 1
fi

if [ -e "build.sh" ]; then
    source ./build.sh
fi

apt update
apt upgrade -y
apt install -y coreutils clang curl debianutils make
hash -r

## Override function from build.sh since we are
## building for host.
neoterm_step_configure () {
    export PKG_CONFIG_SYSROOT_DIR="${NEOTERM_PREFIX}"

    ./configure -v \
        -opensource \
        -confirm-license \
        -release \
        -platform neoterm \
        -shared \
        -no-rpath \
        -no-use-gold-linker \
        -prefix "${NEOTERM_PREFIX}" \
        -docdir "${NEOTERM_PREFIX}/share/doc/qt" \
        -archdatadir "${NEOTERM_PREFIX}/lib/qt" \
        -datadir "${NEOTERM_PREFIX}/share/qt" \
        -plugindir "${NEOTERM_PREFIX}/libexec/qt" \
        -nomake examples \
        -no-pch \
        -no-accessibility \
        -no-glib \
        -icu \
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
        -sql-sqlite
}

if [ ! -e "qtbase-everywhere-opensource-src-${NEOTERM_PKG_VERSION}.tar.xz" ]; then
    echo "[*] Downloading Qt sources..."
    curl -L --output "qtbase-everywhere-opensource-src-${NEOTERM_PKG_VERSION}.tar.xz" "${NEOTERM_PKG_SRCURL}"
fi

echo "[*] Unpacking Qt sources..."
rm -rf "qtbase-everywhere-src-${NEOTERM_PKG_VERSION}"
tar xf "qtbase-everywhere-opensource-src-${NEOTERM_PKG_VERSION}.tar.xz"

cd "qtbase-everywhere-src-${NEOTERM_PKG_VERSION}" && {
    ## Patch the source
    for i in `ls ../../qt5-qtbase/*.patch`; do
        patch -p1 -Ni "${i}"
    done
    unset i

    ## We need only qmake generated by configure, so ignoring
    ## errors here.
    set +e
    echo "[*] Running ./configure..."
    neoterm_step_configure
    set -e

    cd qmake && {
        ## Bootstrap qmake.
        echo "[*] Bootstrapping qmake..."
        ../bin/qmake -spec neoterm -o Makefile.qmake-aux qmake-aux.pro
        make -f Makefile.qmake-aux

        ## Just verify.
        echo "[*] Verifying..."
        ./qmake -spec neoterm -o Makefile.qmake-aux qmake-aux.pro
        make -f Makefile.qmake-aux

        cd -
    }

    cd ../
}

echo "[*] Done. Check file './qmake-$(uname -m)-linux-android'."
cp "qtbase-everywhere-src-${NEOTERM_PKG_VERSION}/qmake/qmake" "./qmake-$(uname -m)-linux-android"
