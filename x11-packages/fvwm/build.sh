NEOTERM_PKG_HOMEPAGE=https://www.fvwm.org/
NEOTERM_PKG_DESCRIPTION="A multiple large virtual desktop window manager originally derived from twm."
# Licenses: GPL-2.0, FVWM
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="COPYING"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.7.0
NEOTERM_PKG_REVISION=6
NEOTERM_PKG_SRCURL=https://github.com/fvwmorg/fvwm/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=a0662354ce5762e894665a27e59b437cb422bfe738a8cf901665c6ee0d0b9ab8
NEOTERM_PKG_DEPENDS="fontconfig, fribidi, glib, libandroid-shmem, libcairo, libice, libiconv, libpng, librsvg, libsm, libx11, libxcursor, libxext, libxft, libxinerama, libxpm, libxrender, readline"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_func_setpgrp_void=yes ac_cv_func_mkstemp=no ac_cv_func_getpwuid=no"

neoterm_step_pre_configure() {
	autoreconf -fi
	export LIBS="-landroid-shmem"
}
