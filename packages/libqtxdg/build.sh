NEOTERM_PKG_HOMEPAGE=https://lxqt.github.io
NEOTERM_PKG_DESCRIPTION="Qt 5 implementation of freedesktop.org XDG specifications"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="Simeon Huang <symeon@librehat.com>"
NEOTERM_PKG_VERSION="3.12.0"
NEOTERM_PKG_SRCURL="https://github.com/lxqt/libqtxdg/releases/download/${NEOTERM_PKG_VERSION}/libqtxdg-${NEOTERM_PKG_VERSION}.tar.xz"
NEOTERM_PKG_SHA256=726856ff447220575c84461800b151328e784c6c326a5065ef3f9a7f9506d4dc
NEOTERM_PKG_DEPENDS="libc++, qt5-qtbase, qt5-qtsvg, glib"
NEOTERM_PKG_BUILD_DEPENDS="lxqt-build-tools, qt5-qttools-cross-tools"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DGLIB_GIO_UNIX_INCLUDE_DIR=$NEOTERM_PREFIX/include/gio-unix-2.0
"
NEOTERM_PKG_AUTO_UPDATE=true
