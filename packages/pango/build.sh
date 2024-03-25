NEOTERM_PKG_HOMEPAGE=https://www.pango.org/
NEOTERM_PKG_DESCRIPTION="Library for laying out and rendering text"
NEOTERM_PKG_LICENSE="LGPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
_MAJOR_VERSION=1.50
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.14
NEOTERM_PKG_SRCURL=https://ftp.gnome.org/pub/GNOME/sources/pango/${_MAJOR_VERSION}/pango-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=1d67f205bfc318c27a29cfdfb6828568df566795df0cb51d2189cde7f2d581e8
NEOTERM_PKG_DEPENDS="fontconfig, freetype, fribidi, glib, harfbuzz, libcairo, libx11, libxft, libxrender"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner"
NEOTERM_PKG_BREAKS="pango-dev"
NEOTERM_PKG_REPLACES="pango-dev"
NEOTERM_PKG_DISABLE_GIR=false
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dintrospection=enabled
"

neoterm_step_pre_configure() {
	neoterm_setup_gir
}

neoterm_step_post_make_install() {
	install -Dm600 $NEOTERM_PKG_BUILDER_DIR/pango-view.1 \
		$NEOTERM_PREFIX/share/man/man1/pango-view.1
}
