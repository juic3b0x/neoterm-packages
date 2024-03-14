NEOTERM_PKG_HOMEPAGE=https://github.com/jordansissel/xdotool
NEOTERM_PKG_DESCRIPTION="simulate (generate) X11 keyboard/mouse input events"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.20211022.1
NEOTERM_PKG_SRCURL=https://github.com/jordansissel/xdotool/releases/download/v${NEOTERM_PKG_VERSION}/xdotool-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=96f0facfde6d78eacad35b91b0f46fecd0b35e474c03e00e30da3fdd345f9ada
NEOTERM_PKG_DEPENDS="libx11, libxtst, libxinerama, libxkbcommon"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="
INSTALLMAN=$NEOTERM_PREFIX/share/man
"
