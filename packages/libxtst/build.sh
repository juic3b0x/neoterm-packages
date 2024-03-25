# X11 package
NEOTERM_PKG_HOMEPAGE=https://xorg.freedesktop.org/
NEOTERM_PKG_DESCRIPTION="X11 Testing -- Resource extension library"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.2.4
NEOTERM_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libXtst-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=84f5f30b9254b4ffee14b5b0940e2622153b0d3aed8286a3c5b7eeb340ca33c8
NEOTERM_PKG_DEPENDS="libx11, libxext, libxi"
NEOTERM_PKG_BUILD_DEPENDS="libxfixes, xorg-util-macros"
