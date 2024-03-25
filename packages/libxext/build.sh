# X11 package
NEOTERM_PKG_HOMEPAGE=https://xorg.freedesktop.org/
NEOTERM_PKG_DESCRIPTION="X11 miscellaneous extensions library"
# Licenses: MIT, HPND, ISC
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="COPYING"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.3.5
NEOTERM_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libXext-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=db14c0c895c57ea33a8559de8cb2b93dc76c42ea4a39e294d175938a133d7bca
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--enable-malloc0returnsnull"
NEOTERM_PKG_DEPENDS="libx11"
NEOTERM_PKG_BUILD_DEPENDS="xorgproto, xorg-util-macros"
