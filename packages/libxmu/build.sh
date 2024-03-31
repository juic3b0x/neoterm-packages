NEOTERM_PKG_HOMEPAGE=https://xorg.freedesktop.org/
NEOTERM_PKG_DESCRIPTION="X11 miscellaneous micro-utility library"
# Licenses: MIT, HPND, ISC
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="COPYING"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.1.4
NEOTERM_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libXmu-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=210de3ab9c3e9382572c25d17c2518a854ce6e2c62c5f8315deac7579e758244
NEOTERM_PKG_DEPENDS="libx11, libxext, libxt"
NEOTERM_PKG_BUILD_DEPENDS="xorg-util-macros"
