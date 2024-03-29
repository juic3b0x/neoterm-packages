NEOTERM_PKG_HOMEPAGE=https://xorg.freedesktop.org/
NEOTERM_PKG_DESCRIPTION="Server access control program for X"
# Licenses: MIT, HPND
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="COPYING"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.0.9
NEOTERM_PKG_SRCURL=https://xorg.freedesktop.org/archive/individual/app/xhost-$NEOTERM_PKG_VERSION.tar.xz
NEOTERM_PKG_SHA256=ea86b531462035b19a2e5e01ef3d9a35cca7d984086645e2fc844d8f0e346645
NEOTERM_PKG_DEPENDS="libx11, libxmu"
NEOTERM_PKG_BUILD_DEPENDS="xorg-util-macros"
