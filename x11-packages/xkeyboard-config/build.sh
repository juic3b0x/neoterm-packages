NEOTERM_PKG_HOMEPAGE=https://www.freedesktop.org/wiki/Software/XKeyboardConfig/
NEOTERM_PKG_DESCRIPTION="X keyboard configuration files"
# Licenses: HPND, MIT
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="COPYING"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.41"
NEOTERM_PKG_SRCURL=https://xorg.freedesktop.org/archive/individual/data/xkeyboard-config/xkeyboard-config-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=f02cd6b957295e0d50236a3db15825256c92f67ef1f73bf1c77a4b179edf728f
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dxkb-base=${NEOTERM_PREFIX}/share/X11/xkb
-Dcompat-rules=true
-Dxorg-rules-symlinks=true
"
