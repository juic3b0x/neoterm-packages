NEOTERM_PKG_HOMEPAGE=https://wiki.gnome.org/Projects/Libpeas
NEOTERM_PKG_DESCRIPTION="A gobject-based plugins engine"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
_MAJOR_VERSION=1.36
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.0
NEOTERM_PKG_SRCURL=https://download.gnome.org/sources/libpeas/${_MAJOR_VERSION}/libpeas-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=297cb9c2cccd8e8617623d1a3e8415b4530b8e5a893e3527bbfd1edd13237b4c
NEOTERM_PKG_DEPENDS="glib, gobject-introspection, gtk3"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner"
NEOTERM_PKG_DISABLE_GIR=false
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dlua51=false
-Dpython3=false
-Dintrospection=true
-Ddemos=false
-Dgtk_doc=false
"

neoterm_step_pre_configure() {
	neoterm_setup_gir
}
