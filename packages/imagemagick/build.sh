NEOTERM_PKG_HOMEPAGE=https://www.imagemagick.org/
NEOTERM_PKG_DESCRIPTION="Suite to create, edit, compose, or convert images in a variety of formats"
NEOTERM_PKG_LICENSE="ImageMagick"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="7.1.1.29"
_VERSION="${NEOTERM_PKG_VERSION%.*}-${NEOTERM_PKG_VERSION##*.}"
#NEOTERM_PKG_SRCURL=https://github.com/ImageMagick/ImageMagick/archive/refs/tags/${_VERSION}.tar.gz
NEOTERM_PKG_SRCURL=https://imagemagick.org/archive/releases/ImageMagick-${_VERSION}.tar.xz
NEOTERM_PKG_SHA256=f140465fbeb0b4724cba4394bc6f6fb32715731c1c62572d586f4f1c8b9b0685
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="fftw, fontconfig, freetype, gdk-pixbuf, glib, harfbuzz, imath, libandroid-support, libbz2, libc++, libcairo, libheif, libjpeg-turbo, libjxl, liblzma, libpng, librsvg, libtiff, libwebp, libx11, libxext, libxml2, littlecms, openexr, openjpeg, pango, zlib"
NEOTERM_PKG_BREAKS="imagemagick-dev, imagemagick-x"
NEOTERM_PKG_REPLACES="imagemagick-dev, imagemagick-x"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--with-x
--without-gvc
--with-magick-plus-plus=yes
--with-bzlib=yes
--with-xml=yes
--with-rsvg=yes
--with-lzma
--with-jxl=yes
--with-openexr
--with-fftw
--disable-openmp
ac_cv_func_ftime=no
"

NEOTERM_PKG_RM_AFTER_INSTALL="
share/ImageMagick-7/francais.xml
"

neoterm_step_pre_configure() {
	export LDFLAGS+=" $($CC -print-libgcc-file-name)"

	# Value of PKG_CONFIG becomes hardcoded in bin/*-config
	export PKG_CONFIG=pkg-config
}
