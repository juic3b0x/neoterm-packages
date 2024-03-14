# x11-packages
NEOTERM_PKG_HOMEPAGE=https://sdlpango.sourceforge.net/
NEOTERM_PKG_DESCRIPTION="Connects Pango to SDL"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.1.2
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/sdlpango/SDL_Pango-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=7f75d3b97acf707c696ea126424906204ebfa07660162de925173cdd0257eba4
NEOTERM_PKG_DEPENDS="fontconfig, freetype, glib, harfbuzz, pango, sdl"

neoterm_step_post_get_source() {
	neoterm_download \
		"https://ftp-osl.osuosl.org/pub/gentoo/distfiles/SDL_Pango-0.1.2-API-adds.patch" \
		$NEOTERM_PKG_CACHEDIR/SDL_Pango-0.1.2-API-adds.patch \
		5a989c7acb539fce640323d3995cca8913a4b8869f5c690b78501ec6b5c86d5d
	cat $NEOTERM_PKG_CACHEDIR/SDL_Pango-0.1.2-API-adds.patch | patch --silent -p0
}

neoterm_step_pre_configure() {
	mkdir -p m4
	cp $NEOTERM_PREFIX/share/aclocal/sdl.m4 m4/
	autoreconf -fi -Im4

	CPPFLAGS+=" -I$NEOTERM_PREFIX/include/SDL -D__FT2_BUILD_UNIX_H__"
}
