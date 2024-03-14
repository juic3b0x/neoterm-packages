NEOTERM_PKG_HOMEPAGE=https://github.com/any1/neatvnc
NEOTERM_PKG_DESCRIPTION="A liberally licensed VNC server library with a clean interface"
NEOTERM_PKG_LICENSE="ISC"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.8.0"
NEOTERM_PKG_SRCURL=https://github.com/any1/neatvnc/archive/refs/tags/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=6c0feff5d8de20d1f47938936fd2c0e99dc56c28033e2149863cf70ce6cfcc5c
NEOTERM_PKG_DEPENDS="libaml, libdrm, libgmp, libgnutls, libjpeg-turbo, libnettle, libpixman, zlib"
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Djpeg=enabled
-Dtls=enabled
-Dnettle=enabled
-Dgbm=disabled
"
