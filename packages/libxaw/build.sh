NEOTERM_PKG_HOMEPAGE=https://xorg.freedesktop.org/
NEOTERM_PKG_DESCRIPTION="X11 Athena Widget library"
# Licenses: MIT, HPND
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="COPYING"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.0.15
NEOTERM_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libXaw-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=ab35f70fde9fb02cc71b342f654846a74328b74cb3a0703c02d20eddb212754a
NEOTERM_PKG_DEPENDS="libx11, libxext, libxmu, libxpm, libxt"
NEOTERM_PKG_BUILD_DEPENDS="xorgproto"
