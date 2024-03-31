NEOTERM_PKG_HOMEPAGE=https://lxqt.github.io
NEOTERM_PKG_DESCRIPTION="Library providing components to build desktop file managers"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="Simeon Huang <symeon@librehat.com>"
NEOTERM_PKG_VERSION="1.4.0"
NEOTERM_PKG_SRCURL="https://github.com/lxqt/libfm-qt/releases/download/${NEOTERM_PKG_VERSION}/libfm-qt-${NEOTERM_PKG_VERSION}.tar.xz"
NEOTERM_PKG_SHA256=2ee3882e023df1df31a53f03575856d38364aa63bec39e9a47fde3730d6f7753
NEOTERM_PKG_DEPENDS="libc++, qt5-qtbase, qt5-qtx11extras, glib, libxcb, libexif, lxqt-menu-data, menu-cache"
NEOTERM_PKG_BUILD_DEPENDS="lxqt-build-tools, qt5-qtbase-cross-tools, qt5-qttools-cross-tools"
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DGLIB_GIO_UNIX_INCLUDE_DIR=$NEOTERM_PREFIX/include/gio-unix-2.0
"
