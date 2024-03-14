NEOTERM_PKG_HOMEPAGE=https://libmatekbd.mate-desktop.dev/
NEOTERM_PKG_DESCRIPTION="libmatekbd is a fork of libgnomekbd"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.28.0"
NEOTERM_PKG_SRCURL=https://github.com/mate-desktop/libmatekbd/releases/download/v$NEOTERM_PKG_VERSION/libmatekbd-$NEOTERM_PKG_VERSION.tar.xz
NEOTERM_PKG_SHA256=5d2e58483c2b23d33503d24c88f8b90a28cc0189d7e4001b3e273a604f6fe80e
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="atk, gdk-pixbuf, glib, gtk3, harfbuzz, libcairo, libx11, libxklavier, pango, zlib"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner"
NEOTERM_PKG_DISABLE_GIR=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
LIBXKLAVIER=${NEOTERM_PREFIX}/lib/libxklavier.so
--enable-introspection=yes
"

neoterm_step_pre_configure() {
	neoterm_setup_gir

	export GLIB_COMPILE_RESOURCES="glib-compile-resources"
	export GLIB_COMPILE_SCHEMAS="glib-compile-schemas"
}
