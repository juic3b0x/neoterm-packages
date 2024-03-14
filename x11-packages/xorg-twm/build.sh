NEOTERM_PKG_HOMEPAGE=https://xorg.freedesktop.org/
NEOTERM_PKG_DESCRIPTION="Tab Window Manager for the X Window System"
# Licenses: MIT, HPND
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="COPYING"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.0.12
NEOTERM_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/app/twm-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=aaf201d4de04c1bb11eed93de4bee0147217b7bdf61b7b761a56b2fdc276afe4
NEOTERM_PKG_DEPENDS="libice, libsm, libx11, libxext, libxmu, libxrandr, libxt"
NEOTERM_PKG_BUILD_DEPENDS="xorg-util-macros"
