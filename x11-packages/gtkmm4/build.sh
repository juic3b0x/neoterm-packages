NEOTERM_PKG_HOMEPAGE=https://www.gtkmm.org/
NEOTERM_PKG_DESCRIPTION="The C++ API for GTK"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
_MAJOR_VERSION=4.10
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.0
NEOTERM_PKG_SRCURL=https://download.gnome.org/sources/gtkmm/${_MAJOR_VERSION}/gtkmm-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=e1b109771557ecc53cba915a80b6ede827ffdbd0049c62fdf8bd7fa79afcc6eb
NEOTERM_PKG_DEPENDS="gdk-pixbuf, glib, graphene, gtk4, libc++, libcairo, libcairomm-1.16, libglibmm-2.68, libpangomm-2.48, libsigc++-3.0"
NEOTERM_PKG_BUILD_DEPENDS="libepoxy"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dbuild-demos=false
-Dbuild-tests=false
"

neoterm_step_post_massage() {
	local _GUARD_FILE="lib/libgtkmm-4.0.so"
	if [ ! -e "${_GUARD_FILE}" ]; then
		neoterm_error_exit "Error: file ${_GUARD_FILE} not found."
	fi
}
