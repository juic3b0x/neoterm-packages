NEOTERM_PKG_HOMEPAGE=https://ccextractor.org/
NEOTERM_PKG_DESCRIPTION="A tool used to produce subtitles for TV recordings"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.94
NEOTERM_PKG_REVISION=4
NEOTERM_PKG_SRCURL=https://github.com/CCExtractor/ccextractor/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=9c7be386257c69b5d8cd9d7466dbf20e3a45cea950cc8ca7486a956c3be54a42
NEOTERM_PKG_DEPENDS="freetype, gpac, libiconv, libmd, libpng, libprotobuf-c, utf8proc"
NEOTERM_PKG_BUILD_DEPENDS="zlib"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DWITHOUT_RUST=ON
"

neoterm_step_post_get_source() {
	rm -rf src/thirdparty
	touch src/lib_ccx/config.h
}

neoterm_step_pre_configure() {
	NEOTERM_PKG_SRCDIR+="/src"

	CPPFLAGS+=" -D__USE_GNU"
	CFLAGS+=" -fcommon"
	LDFLAGS+=" -liconv"
}
