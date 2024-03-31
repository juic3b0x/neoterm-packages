NEOTERM_PKG_HOMEPAGE=https://www.gimp.org/
NEOTERM_PKG_DESCRIPTION="GNU Image Manipulation Program"
NEOTERM_PKG_LICENSE="GPL-3.0, LGPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.10.36"
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://download.gimp.org/mirror/pub/gimp/v${NEOTERM_PKG_VERSION%.*}/gimp-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=3d3bc3c69a4bdb3aea9ba2d5385ed98ea03953f3857aafd1d6976011ed7cdbb2
NEOTERM_PKG_DEPENDS="aalib, atk, babl, fontconfig, freetype, gdk-pixbuf, gegl, gexiv2, ghostscript, gimp-data, glib, glib-networking, gtk2, harfbuzz, hicolor-icon-theme, json-glib, libandroid-execinfo, libandroid-shmem, libc++, libcairo, libheif, libjpeg-turbo, libjxl, libmypaint, libpng, librsvg, libtiff, libwebp, libxcursor, libxmu, libxpm, littlecms, mypaint-brushes, openexr, openjpeg, pango, poppler, poppler-data, zlib"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-python
--disable-vector-icons
ac_cv_func_bind_textdomain_codeset=yes
ac_cv_path_GEGL=/usr/bin/gegl
HOST_GLIB_COMPILE_RESOURCES=glib-compile-resources
"
NEOTERM_PKG_RM_AFTER_INSTALL="lib/locale"

neoterm_step_pre_configure() {
	CXXFLAGS+=" -Wno-error=register"
	LDFLAGS+=" -landroid-shmem -lm"

	sed -i 's/\(mypaint-brushes-\)1/\12/g' configure
}
