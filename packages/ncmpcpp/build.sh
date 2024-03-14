NEOTERM_PKG_HOMEPAGE=https://rybczak.net/ncmpcpp/
NEOTERM_PKG_DESCRIPTION="NCurses Music Player Client (Plus Plus)"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.9.2
NEOTERM_PKG_REVISION=12
NEOTERM_PKG_SRCURL=https://rybczak.net/ncmpcpp/stable/ncmpcpp-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=faabf6157c8cb1b24a059af276e162fa9f9a3b9cd3810c43b9128860c9383a1b
NEOTERM_PKG_DEPENDS="boost, fftw, libandroid-support, libc++, libcurl, libicu, libmpdclient, ncurses, readline, taglib"
NEOTERM_PKG_BUILD_DEPENDS="boost-headers"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-clock
--enable-outputs
--enable-visualizer
--with-taglib
"

neoterm_step_pre_configure() {
	./autogen.sh
	CXXFLAGS+=" -DNCURSES_WIDECHAR -U_XOPEN_SOURCE"
}
