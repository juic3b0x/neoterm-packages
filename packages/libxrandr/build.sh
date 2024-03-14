# X11 package
NEOTERM_PKG_HOMEPAGE=https://xorg.freedesktop.org/
NEOTERM_PKG_DESCRIPTION="X11 RandR extension library"
# License: HPND
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="COPYING"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.5.4"
NEOTERM_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libXrandr-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=1ad5b065375f4a85915aa60611cc6407c060492a214d7f9daf214be752c3b4d3
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libx11, libxext, libxrender"
NEOTERM_PKG_BUILD_DEPENDS="xorgproto, xorg-util-macros"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--enable-malloc0returnsnull"
