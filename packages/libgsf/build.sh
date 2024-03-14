NEOTERM_PKG_HOMEPAGE=https://gitlab.gnome.org/GNOME/libgsf
NEOTERM_PKG_DESCRIPTION="The G Structured File Library"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.14.52"
NEOTERM_PKG_SRCURL=https://download.gnome.org/sources/libgsf/${NEOTERM_PKG_VERSION%.*}/libgsf-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=9181c914b9fac0e05d6bcaa34c7b552fe5fc0961d3c9f8c01ccc381fb084bcf0
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="glib, libbz2, libxml2, zlib"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner"
NEOTERM_PKG_DISABLE_GIR=false
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-introspection
--with-bz2
--without-gdk-pixbuf
"

neoterm_step_pre_configure() {
	NEOTERM_PKG_VERSION=. neoterm_setup_gir
	CFLAGS+=" -I${NEOTERM_PREFIX}/include/libxml2 -includelibxml/xmlerror.h"
}

neoterm_step_post_configure() {
	touch ./gsf/g-ir-scanner
}
