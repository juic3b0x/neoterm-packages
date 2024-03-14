NEOTERM_PKG_HOMEPAGE=https://wiki.gnome.org/libgxps
NEOTERM_PKG_DESCRIPTION="handling and rendering XPS documents"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
_MAJOR_VERSION=0.3
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.2
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://download.gnome.org/sources/libgxps/${_MAJOR_VERSION}/libgxps-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=6d27867256a35ccf9b69253eb2a88a32baca3b97d5f4ef7f82e3667fa435251c
NEOTERM_PKG_DEPENDS="freetype, glib, libarchive, libcairo, libjpeg-turbo, libpng, libtiff, littlecms"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner"
NEOTERM_PKG_DISABLE_GIR=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Denable-test=false
-Denable-man=true
-Ddisable-introspection=false
"

neoterm_step_pre_configure() {
	neoterm_setup_gir
}
