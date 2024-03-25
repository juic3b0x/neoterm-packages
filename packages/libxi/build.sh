# X11 package
NEOTERM_PKG_HOMEPAGE=https://xorg.freedesktop.org/
NEOTERM_PKG_DESCRIPTION="X11 Input extension library"
# Licenses: MIT, HPND
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="COPYING"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.8.1
NEOTERM_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libXi-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=89bfc0e814f288f784202e6e5f9b362b788ccecdeb078670145eacd8749656a7
NEOTERM_PKG_DEPENDS="libx11, libxext"
NEOTERM_PKG_BUILD_DEPENDS="libxfixes, xorgproto, xorg-util-macros"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--enable-malloc0returnsnull"
