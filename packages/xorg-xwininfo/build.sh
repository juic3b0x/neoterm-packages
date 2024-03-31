NEOTERM_PKG_HOMEPAGE=https://xorg.freedesktop.org/
NEOTERM_PKG_DESCRIPTION="Utility to print information about X11 windows"
# Licenses: MIT, HPND
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="COPYING"
NEOTERM_PKG_MAINTAINER="Rafael Kitover <rkitover@gmail.com>"
NEOTERM_PKG_VERSION=1.1.6
NEOTERM_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/app/xwininfo-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=3518897c17448df9ba99ad6d9bb1ca0f17bc0ed7c0fd61281b34ceed29a9253f
NEOTERM_PKG_DEPENDS="libiconv, libxcb"
NEOTERM_PKG_BUILD_DEPENDS="libx11, xorg-util-macros"
