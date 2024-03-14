NEOTERM_PKG_HOMEPAGE=https://gitlab.gnome.org/GNOME/libhandy/
NEOTERM_PKG_DESCRIPTION="Building blocks for modern adaptive GNOME apps"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
_MAJOR_VERSION=0.0
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.13
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://deb.debian.org/debian/pool/main/libh/libhandy/libhandy_${NEOTERM_PKG_VERSION}.orig.tar.gz
NEOTERM_PKG_SHA256=4dcd9d249558834bd5430445d3674e9e3cff356e35f0c1dd368c3af50fa15b6d
NEOTERM_PKG_DEPENDS="atk, gdk-pixbuf, glib, gtk3, libcairo, pango"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner, valac"
NEOTERM_PKG_DISABLE_GIR=false
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dintrospection=enabled
-Dvapi=true
-Dtests=false
-Dexamples=false
-Dglade_catalog=disabled
"

neoterm_step_pre_configure() {
	neoterm_setup_gir
}

neoterm_step_post_massage() {
	local _GUARD_FILE="lib/${NEOTERM_PKG_NAME}.so"
	if [ ! -e "${_GUARD_FILE}" ]; then
		neoterm_error_exit "Error: file ${_GUARD_FILE} not found."
	fi
}
