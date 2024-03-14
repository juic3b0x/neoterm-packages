# X11 package
NEOTERM_PKG_HOMEPAGE=https://xorg.freedesktop.org/
NEOTERM_PKG_DESCRIPTION="Library for the X Video (Xv) extension to the X Window System"
# License: HPND
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="COPYING"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.0.12
NEOTERM_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libXv-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=aaf7fa09f689f7a2000fe493c0d64d1487a1210db154053e9e2336b860c63848
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--enable-malloc0returnsnull"
NEOTERM_PKG_DEPENDS="libx11, libxext"
NEOTERM_PKG_BUILD_DEPENDS="xorgproto"
