NEOTERM_PKG_HOMEPAGE=https://wiki.gnome.org/action/show/Projects/LibRsvg
NEOTERM_PKG_DESCRIPTION="Library to render SVG files using cairo"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.57.2"
NEOTERM_PKG_SRCURL=https://ftp.gnome.org/pub/GNOME/sources/librsvg/${NEOTERM_PKG_VERSION%.*}/librsvg-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=9c2b73947924d3f0f5653436c3ee3b170128930ab6abd2303bb6d727b88d6471
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="fontconfig, freetype, gdk-pixbuf, glib, harfbuzz, libcairo, libpng, libxml2, pango"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner"
NEOTERM_PKG_BREAKS="librsvg-dev"
NEOTERM_PKG_REPLACES="librsvg-dev"
NEOTERM_PKG_DISABLE_GIR=false
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_path_GDK_PIXBUF_QUERYLOADERS=$NEOTERM_PREFIX/bin/gdk-pixbuf-query-loaders
--disable-gtk-doc
--enable-introspection
--disable-static
"

neoterm_step_pre_configure() {
	NEOTERM_PKG_VERSION=. neoterm_setup_gir
	neoterm_setup_rust

	LDFLAGS+=" -fuse-ld=lld"

	# Work around https://gitlab.gnome.org/GNOME/librsvg/-/issues/820
	if [ "$NEOTERM_ARCH" = "arm" ]; then
		LDFLAGS+=" -Wl,-z,muldefs"
	fi

	# See https://github.com/GNOME/librsvg/blob/master/COMPILING.md
	export RUST_TARGET=$CARGO_TARGET_NAME
}

neoterm_step_post_massage() {
	find lib -name '*.la' -delete
}
