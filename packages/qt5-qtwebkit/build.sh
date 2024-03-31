NEOTERM_PKG_HOMEPAGE=https://github.com/qtwebkit/qtwebkit
NEOTERM_PKG_DESCRIPTION="Qt 5 WebKit Library"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="Simeon Huang <symeon@librehat.com>"
NEOTERM_PKG_VERSION="5.212.0-alpha4"
NEOTERM_PKG_REVISION=15
NEOTERM_PKG_SRCURL="https://github.com/qtwebkit/qtwebkit/releases/download/qtwebkit-${NEOTERM_PKG_VERSION}/qtwebkit-${NEOTERM_PKG_VERSION}.tar.xz"
NEOTERM_PKG_SHA256=9ca126da9273664dd23a3ccd0c9bebceb7bb534bddd743db31caf6a5a6d4a9e6
NEOTERM_PKG_DEPENDS="libc++, libhyphen, libicu, libjpeg-turbo, libpng, libsqlite, libwebp, libx11, libxml2, libxslt, qt5-qtbase, qt5-qtdeclarative, qt5-qtlocation, qt5-qtmultimedia, qt5-qtsensors, zlib"
NEOTERM_PKG_BUILD_DEPENDS="libxcomposite, qt5-qtbase-cross-tools"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="-DPORT=Qt -DUSE_LD_GOLD=OFF -DUSE_GSTREAMER=OFF -DUSE_QT_MULTIMEDIA=ON -DENABLE_OPENGL=OFF -DENABLE_SAMPLING_PROFILER=OFF -DENABLE_WEBKIT2=OFF"

# TODO SAMPLING_PROFILER requires glibc. We might be able to patch the source to make it work with bionic
