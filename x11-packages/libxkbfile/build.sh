NEOTERM_PKG_HOMEPAGE=https://xorg.freedesktop.org/
NEOTERM_PKG_DESCRIPTION="X11 keyboard file manipulation library"
# Licenses: HPND, MIT
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="COPYING"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.1.2
NEOTERM_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libxkbfile-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=b8a3784fac420b201718047cfb6c2d5ee7e8b9481564c2667b4215f6616644b1
NEOTERM_PKG_DEPENDS="libx11"
NEOTERM_PKG_BUILD_DEPENDS="xorg-util-macros"
