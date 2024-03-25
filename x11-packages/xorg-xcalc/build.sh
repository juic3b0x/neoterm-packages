NEOTERM_PKG_HOMEPAGE=https://xorg.freedesktop.org/
NEOTERM_PKG_DESCRIPTION="Scientific calculator for X"
# Licenses: MIT, HPND
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="COPYING"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.1.2
NEOTERM_PKG_SRCURL=https://xorg.freedesktop.org/archive/individual/app/xcalc-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=8578dfa1457e94289f6d6ed6146714307d8a73a1b54d2f42af1321b625fc1cd4
NEOTERM_PKG_DEPENDS="libx11, libxaw, libxt, xorg-fonts-75dpi | xorg-fonts-100dpi"
NEOTERM_PKG_BUILD_DEPENDS="xorg-util-macros"
