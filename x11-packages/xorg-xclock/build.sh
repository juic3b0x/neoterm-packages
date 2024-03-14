NEOTERM_PKG_HOMEPAGE=https://xorg.freedesktop.org/
NEOTERM_PKG_DESCRIPTION="X clock"
# Licenses: MIT, HPND
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="COPYING"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.1.1
NEOTERM_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/app/xclock-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=df7ceabf8f07044a2fde4924d794554996811640a45de40cb12c2cf1f90f742c
NEOTERM_PKG_DEPENDS="libiconv, libx11, libxaw, libxft, libxkbfile, libxmu, libxrender, libxt"
NEOTERM_PKG_BUILD_DEPENDS="xorg-util-macros"
NEOTERM_PKG_CONFLICTS="xclock"
NEOTERM_PKG_REPLACES="xclock"
