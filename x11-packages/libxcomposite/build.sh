NEOTERM_PKG_HOMEPAGE=https://xorg.freedesktop.org/
NEOTERM_PKG_DESCRIPTION="X11 Composite extension library"
# Licenses: HPND, MIT
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="COPYING"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.4.6
NEOTERM_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libXcomposite-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=fe40bcf0ae1a09070eba24088a5eb9810efe57453779ec1e20a55080c6dc2c87
NEOTERM_PKG_DEPENDS="libx11"
NEOTERM_PKG_BUILD_DEPENDS="libxfixes, xorgproto, xorg-util-macros"
