NEOTERM_PKG_HOMEPAGE="https://xorg.freedesktop.org/"
NEOTERM_PKG_DESCRIPTION="Primitive command line interface to RandR extension"
# License: HPND
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="COPYING"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.5.2
NEOTERM_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/app/xrandr-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=c8bee4790d9058bacc4b6246456c58021db58a87ddda1a9d0139bf5f18f1f240
NEOTERM_PKG_DEPENDS="libx11, libxrandr"
NEOTERM_PKG_BUILD_DEPENDS="xorg-util-macros, xorgproto"
