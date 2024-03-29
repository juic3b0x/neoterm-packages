NEOTERM_PKG_HOMEPAGE=https://xorg.freedesktop.org/
NEOTERM_PKG_DESCRIPTION="X11 Direct Graphics Access extension library"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.1.6
NEOTERM_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libXxf86dga-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=be44427579808fe3a217d59f51cae756a26913eb6e4c8738ccab65ff56d7980f
NEOTERM_PKG_DEPENDS="libx11, libxext"
NEOTERM_PKG_BUILD_DEPENDS="xorg-util-macros"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--enable-malloc0returnsnull"
