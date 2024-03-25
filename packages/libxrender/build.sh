# X11 package
NEOTERM_PKG_HOMEPAGE=https://xorg.freedesktop.org/
NEOTERM_PKG_DESCRIPTION="X Rendering Extension client library"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.9.11
NEOTERM_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libXrender-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=bc53759a3a83d1ff702fb59641b3d2f7c56e05051fa0cfa93501166fa782dc24
NEOTERM_PKG_DEPENDS="libx11"
NEOTERM_PKG_BUILD_DEPENDS="xorgproto"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--enable-malloc0returnsnull"
