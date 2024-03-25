# X11 package
NEOTERM_PKG_HOMEPAGE=https://xorg.freedesktop.org/
NEOTERM_PKG_DESCRIPTION="FreeType-based font drawing library for X"
# License: HPND
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="COPYING"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.3.8
NEOTERM_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libXft-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=5e8c3c4bc2d4c0a40aef6b4b38ed2fb74301640da29f6528154b5009b1c6dd49
NEOTERM_PKG_DEPENDS="fontconfig, freetype, libx11, libxrender"
