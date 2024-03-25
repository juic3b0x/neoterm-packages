# X11 package
NEOTERM_PKG_HOMEPAGE=https://xorg.freedesktop.org/
NEOTERM_PKG_DESCRIPTION="X11 Session Management library"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.2.4
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libSM-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=fdcbe51e4d1276b1183da77a8a4e74a137ca203e0bcfb20972dd5f3347e97b84
NEOTERM_PKG_DEPENDS="libice, libuuid"
NEOTERM_PKG_BUILD_DEPENDS="xorg-util-macros, xtrans"
