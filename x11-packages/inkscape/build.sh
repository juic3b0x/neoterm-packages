NEOTERM_PKG_HOMEPAGE=https://inkscape.org/
NEOTERM_PKG_DESCRIPTION="Free and open source vector graphics editor"
NEOTERM_PKG_LICENSE="GPL-3.0-or-later"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.3.2"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://media.inkscape.org/dl/resources/file/inkscape-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=dbd1844dc443fe5e10d3e9a887144e5fb7223852fff191cfb5ef7adeab0e086b
NEOTERM_PKG_DEPENDS="boost, double-conversion, fontconfig, freetype, gdk-pixbuf, glib, gsl, gtk3, gtkmm3, harfbuzz, libatkmm-1.6, libc++, libcairo, libcairomm-1.0, libgc, libglibmm-2.4, libiconv, libjpeg-turbo, libpangomm-1.4, libpng, libsigc++-2.0, libsoup, libx11, libxml2, libxslt, littlecms, pango, poppler, potrace, readline, zlib"
NEOTERM_PKG_BUILD_DEPENDS="boost-headers"
NEOTERM_PKG_RECOMMENDS="inkscape-extensions, inkscape-tutorials"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DWITH_GRAPHICS_MAGICK=OFF
-DWITH_GSPELL=OFF
-DWITH_IMAGE_MAGICK=OFF
-DWITH_LIBCDR=OFF
-DWITH_LIBVISIO=OFF
-DWITH_LIBWPG=OFF
"

neoterm_step_pre_configure() {
	CPPFLAGS+=" -DCMS_NO_REGISTER_KEYWORD -I${NEOTERM_PREFIX}/include/libxml2 -include libxml/xmlmemory.h"
	LDFLAGS+=" -Wl,-rpath=$NEOTERM_PREFIX/lib/inkscape"
}

neoterm_step_install_license() {
	local license_file="$NEOTERM_PREFIX/share/inkscape/doc/COPYING"
	if [ ! -e "$license_file" ]; then
		neoterm_error_exit "License file $license_file not found."
	fi
	local doc_dir="$NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME"
	mkdir -p "$doc_dir"
	ln -sf "$license_file" "$doc_dir"/
}
