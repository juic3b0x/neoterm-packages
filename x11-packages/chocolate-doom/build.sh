NEOTERM_PKG_HOMEPAGE=https://www.chocolate-doom.org
NEOTERM_PKG_DESCRIPTION="Historically-accurate Doom, Heretic, Hexen, and Strife ports."
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.0.1
NEOTERM_PKG_REVISION=10
NEOTERM_PKG_SRCURL=https://github.com/chocolate-doom/chocolate-doom/archive/refs/tags/chocolate-doom-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=a54383beef6a52babc5b00d58fcf53a454f012ced7b1936ba359b13f1f10ac66
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_SED_REGEXP='s/.*-//'
NEOTERM_PKG_DEPENDS="sdl2, sdl2-mixer, sdl2-net, mpg123"

neoterm_step_pre_configure(){
	autoreconf -fi
	CFLAGS+=" -fcommon"
}
