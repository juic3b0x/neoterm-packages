NEOTERM_PKG_HOMEPAGE=https://xorg.freedesktop.org/
NEOTERM_PKG_DESCRIPTION="X11 XFree86 video mode extension library"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.1.5
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libXxf86vm-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=247fef48b3e0e7e67129e41f1e789e8d006ba47dba1c0cdce684b9b703f888e7
NEOTERM_PKG_DEPENDS="libx11, libxext"
NEOTERM_PKG_BUILD_DEPENDS="xorgproto, xorg-util-macros"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--enable-malloc0returnsnull"
