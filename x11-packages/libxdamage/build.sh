NEOTERM_PKG_HOMEPAGE=https://xorg.freedesktop.org/
NEOTERM_PKG_DESCRIPTION="X11 damaged region extension library"
# License: HPND
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="COPYING"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.1.6
NEOTERM_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libXdamage-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=52733c1f5262fca35f64e7d5060c6fcd81a880ba8e1e65c9621cf0727afb5d11
NEOTERM_PKG_DEPENDS="libx11, libxfixes"
NEOTERM_PKG_BUILD_DEPENDS="xorgproto"
