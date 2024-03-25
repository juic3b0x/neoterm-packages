NEOTERM_PKG_HOMEPAGE=https://xorg.freedesktop.org/
NEOTERM_PKG_DESCRIPTION="X Present Extension library"
# Licenses: HPND, MIT
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="COPYING"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.0.1
NEOTERM_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libXpresent-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=b964df9e5a066daa5e08d2dc82692c57ca27d00b8cc257e8e960c9f1cf26231b
NEOTERM_PKG_DEPENDS="libx11, libxext, libxfixes, libxrandr"
NEOTERM_PKG_BUILD_DEPENDS="xorgproto"
