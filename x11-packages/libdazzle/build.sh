NEOTERM_PKG_HOMEPAGE=https://gitlab.gnome.org/GNOME/libdazzle
NEOTERM_PKG_DESCRIPTION="A companion library to GObject and Gtk+"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
_MAJOR_VERSION=3.44
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.0
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://download.gnome.org/sources/libdazzle/${_MAJOR_VERSION}/libdazzle-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=3cd3e45eb6e2680cb05d52e1e80dd8f9d59d4765212f0e28f78e6c1783d18eae
NEOTERM_PKG_DEPENDS="gdk-pixbuf, glib, gtk3, libcairo, pango"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner, valac"
NEOTERM_PKG_DISABLE_GIR=false
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Denable_tools=false
-Dwith_introspection=true
-Dwith_vapi=true
-Denable_tests=false
"

neoterm_step_pre_configure() {
	neoterm_setup_gir
}
