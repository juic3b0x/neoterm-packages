NEOTERM_PKG_HOMEPAGE=https://pi4.informatik.uni-mannheim.de/~haensel/cuse/
NEOTERM_PKG_DESCRIPTION="A MIDI-Sequencer which targets both terminal purists and visually impaired people"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.6
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/project/cuse/cuse-${NEOTERM_PKG_VERSION}.tgz
NEOTERM_PKG_SHA256=dc2306c68eeb0eefb2da4739cf42bf3bf49fde3adba6ca58900fb3f78d4f9ad6
NEOTERM_PKG_DEPENDS="libc++, libcdk, ncurses, sdl, sdl-mixer"

neoterm_step_post_get_source() {
	make distclean || :
}

neoterm_step_pre_configure() {
	autoreconf -fi

	LDFLAGS+=" -lSDL"
}
