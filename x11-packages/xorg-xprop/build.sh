NEOTERM_PKG_HOMEPAGE=https://xorg.freedesktop.org/
NEOTERM_PKG_DESCRIPTION="Utility to print properties of X11 windows"
# Licenses: MIT, HPND
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="COPYING"
NEOTERM_PKG_MAINTAINER="Rafael Kitover <rkitover@gmail.com>"
NEOTERM_PKG_VERSION=1.2.6
NEOTERM_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/app/xprop-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=580b8525b12ecc0144aa16c88b0aafa76d2e799b44c8c6c50f9ce92788b5586e
NEOTERM_PKG_DEPENDS="libx11"
NEOTERM_PKG_BUILD_DEPENDS="xorg-util-macros"
