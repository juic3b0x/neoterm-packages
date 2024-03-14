# X11 package
NEOTERM_PKG_HOMEPAGE=https://xorg.freedesktop.org/
NEOTERM_PKG_DESCRIPTION="X11 miscellaneous 'fixes' extension library"
# Licenses: HPND, MIT
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="COPYING"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=6.0.1
NEOTERM_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libXfixes-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=b695f93cd2499421ab02d22744458e650ccc88c1d4c8130d60200213abc02d58
NEOTERM_PKG_DEPENDS="libx11"
NEOTERM_PKG_BUILD_DEPENDS="xorgproto, xorg-util-macros"
