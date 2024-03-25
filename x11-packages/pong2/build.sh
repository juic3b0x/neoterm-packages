NEOTERM_PKG_HOMEPAGE=https://sourceforge.net/projects/pong2.berlios/
NEOTERM_PKG_DESCRIPTION="A Three Dimensional Pong Game"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.1.3
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://download.sourceforge.net/pong2.berlios/pong2-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=7b3601b35a4f2d64e2a4e85b9d6ad2fe84a79d40a39be2909f3e52b094307639
NEOTERM_PKG_DEPENDS="glu, libc++, opengl, openssl, sdl, sdl-image"
NEOTERM_PKG_GROUPS="games"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	cp $NEOTERM_PREFIX/share/aclocal/sdl.m4 m4/
	autoreconf -fi

	CPPFLAGS+=" -I$NEOTERM_PREFIX/include/SDL"
}
