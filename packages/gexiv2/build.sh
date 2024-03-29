NEOTERM_PKG_HOMEPAGE=https://wiki.gnome.org/Projects/gexiv2
NEOTERM_PKG_DESCRIPTION="A GObject-based Exiv2 wrapper"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.14.2"
NEOTERM_PKG_SRCURL=https://download.gnome.org/sources/gexiv2/${NEOTERM_PKG_VERSION%.*}/gexiv2-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=2a0c9cf48fbe8b3435008866ffd40b8eddb0667d2212b42396fdf688e93ce0be
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="exiv2, glib, libc++"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner, valac"
NEOTERM_PKG_DISABLE_GIR=false
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dtests=false
-Dintrospection=true
-Dvapi=true
-Dpython3=false
"

neoterm_step_pre_configure() {
	NEOTERM_PKG_VERSION=. neoterm_setup_gir

	CPPFLAGS+=" -D_LIBCPP_ENABLE_CXX17_REMOVED_FEATURES"
}
