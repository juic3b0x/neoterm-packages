NEOTERM_PKG_HOMEPAGE=https://libportal.org/
NEOTERM_PKG_DESCRIPTION="Flatpak portal library"
NEOTERM_PKG_LICENSE="LGPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.7.1"
NEOTERM_PKG_SRCURL=https://github.com/flatpak/libportal/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=6ac8e0e2aa04f56d0320adff03e5f20a0c5d7d1a33d4b19e22707bfbece0b874
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_DEPENDS="glib"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner, valac, glib-cross"
NEOTERM_PKG_DISABLE_GIR=false
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dbackend-gtk3=enabled
-Dbackend-gtk4=enabled
-Dbackend-qt5=enabled
-Dintrospection=true
-Dvapi=true
-Ddocs=false
-Dtests=false
"

neoterm_step_pre_configure() {
	NEOTERM_PKG_VERSION=. neoterm_setup_gir
	export PKG_CONFIG_LIBDIR="${NEOTERM_PREFIX}/opt/glib/cross/lib/x86_64-linux-gnu/pkgconfig:${PKG_CONFIG_LIBDIR}"
}
