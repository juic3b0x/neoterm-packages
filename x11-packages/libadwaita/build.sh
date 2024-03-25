NEOTERM_PKG_HOMEPAGE=https://gnome.pages.gitlab.gnome.org/libadwaita/
NEOTERM_PKG_DESCRIPTION="Building blocks for modern adaptive GNOME applications"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
_MAJOR_VERSION=1.3
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.3
NEOTERM_PKG_SRCURL=https://download.gnome.org/sources/libadwaita/${_MAJOR_VERSION}/libadwaita-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=3fb9f6f8f570e543ab2dafb8b4b94d8b376c59ad565efadfede44557e3f3a9e1
NEOTERM_PKG_DEPENDS="fribidi, glib, graphene, gtk4, pango"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner, valac"
NEOTERM_PKG_DISABLE_GIR=false
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dintrospection=enabled
-Dvapi=true
-Dtests=false
-Dexamples=false
"

neoterm_step_pre_configure() {
	neoterm_setup_gir
}

neoterm_step_post_massage() {
	local _GUARD_FILE="lib/libadwaita-1.so"
	if [ ! -e "${_GUARD_FILE}" ]; then
		neoterm_error_exit "Error: file ${_GUARD_FILE} not found."
	fi
}
