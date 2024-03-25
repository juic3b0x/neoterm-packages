NEOTERM_PKG_HOMEPAGE=https://gegl.org/
NEOTERM_PKG_DESCRIPTION="Data flow based image processing framework"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.4.48"
NEOTERM_PKG_SRCURL=https://download.gimp.org/pub/gegl/${NEOTERM_PKG_VERSION%.*}/gegl-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=418c26d94be8805d7d98f6de0c6825ca26bd74fcacb6c188da47533d9ee28247
NEOTERM_PKG_DEPENDS="babl, ffmpeg, gdk-pixbuf, glib, json-glib, libandroid-support, libc++, libcairo, libjasper, libjpeg-turbo, libpng, librsvg, libtiff, libwebp, littlecms, openexr, pango, poppler"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner, valac, xorgproto"
NEOTERM_PKG_BREAKS="gegl-dev"
NEOTERM_PKG_REPLACES="gegl-dev"
NEOTERM_PKG_DISABLE_GIR=false
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dintrospection=true
"

neoterm_step_pre_configure() {
	neoterm_setup_gir
}
