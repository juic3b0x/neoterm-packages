NEOTERM_PKG_HOMEPAGE=https://mupdf.com/
NEOTERM_PKG_DESCRIPTION="Lightweight PDF and XPS viewer (library)"
NEOTERM_PKG_LICENSE="AGPL-V3"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.23.11"
NEOTERM_PKG_SRCURL=https://mupdf.com/downloads/archive/mupdf-${NEOTERM_PKG_VERSION}-source.tar.gz
NEOTERM_PKG_SHA256=478f2a167feae2a291c8b8bc5205f2ce2f09f09b574a6eb0525bfad95a3cfe66
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="freetype, gumbo-parser, harfbuzz, jbig2dec, leptonica, libc++, libjpeg-turbo, openjpeg, tesseract, zlib"
NEOTERM_PKG_EXTRA_MAKE_ARGS="prefix=$NEOTERM_PREFIX build=release libs shared=yes tesseract=yes V=1"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_post_get_source() {
	mv pyproject.toml{,.unused}
	mv setup.py{,.unused}
	sed -i "s/HAVE_OBJCOPY := yes/HAVE_OBJCOPY := no/g" $NEOTERM_PKG_SRCDIR/Makerules
}

neoterm_step_pre_configure() {
	rm -rf thirdparty/{freeglut,freetype,harfbuzz,jbig2dec,leptonica,libjpeg,openjpeg,tesseract,zlib}
	export USE_SYSTEM_LIBS=yes
	LDFLAGS+=" -llog"
}

neoterm_step_post_make_install() {
	NEOTERM_PKG_EXTRA_MAKE_ARGS="${NEOTERM_PKG_EXTRA_MAKE_ARGS/shared=yes/}"
	neoterm_step_make
	install -Dm600 -t $NEOTERM_PREFIX/lib build/release*/libmupdf{-third,}.a
}
