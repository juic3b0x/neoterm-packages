NEOTERM_PKG_HOMEPAGE=https://schismtracker.org/
NEOTERM_PKG_DESCRIPTION="A free and open-source reimplementation of Impulse Tracker, a program used to create high quality music"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="20240308"
NEOTERM_PKG_SRCURL=https://github.com/schismtracker/schismtracker/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=2de166f310766225f386555dedc150a8ed25670dd1c61d0b1110f0cd4c886d19
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libx11, libxv, sdl2"
NEOTERM_PKG_BUILD_DEPENDS="xorgproto"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_prog_SDL_CONFIG=$NEOTERM_PREFIX/bin/sdl2-config
ac_cv_prog_WINDRES=
ac_cv_prog_ac_ct_WINDRES=
"

neoterm_step_pre_configure() {
	autoreconf -fi
}

neoterm_step_post_configure() {
	mkdir -p auto
}
