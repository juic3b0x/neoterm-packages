NEOTERM_PKG_HOMEPAGE=https://cairographics.org
NEOTERM_PKG_DESCRIPTION="Cairo 2D vector graphics library"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.18.0
NEOTERM_PKG_SRCURL=https://gitlab.freedesktop.org/cairo/cairo/-/archive/${NEOTERM_PKG_VERSION}/cairo-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=abf8fba4d510086a492783c3e0828e90b32734738fd80906595617d229d02bab
NEOTERM_PKG_DEPENDS="fontconfig, freetype, glib, libandroid-shmem, libandroid-execinfo, liblzo, libpixman, libpng, libx11, libxcb, libxext, libxrender, zlib"
NEOTERM_PKG_BREAKS="libcairo-dev, libcairo-gobject"
NEOTERM_PKG_REPLACES="libcairo-dev, libcairo-gobject"

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dpng=enabled
-Dzlib=enabled
-Dglib=enabled
-Dgtk_doc=false
"

neoterm_step_pre_configure() {
	LDFLAGS+=" -landroid-shmem -landroid-execinfo"
}
