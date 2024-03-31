NEOTERM_PKG_HOMEPAGE=https://www.gtkmm.org/
NEOTERM_PKG_DESCRIPTION="The C++ API for GTK"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
_MAJOR_VERSION=3.24
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.7
NEOTERM_PKG_SRCURL=https://download.gnome.org/sources/gtkmm/${_MAJOR_VERSION}/gtkmm-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=1d7a35af9c5ceccacb244ee3c2deb9b245720d8510ac5c7e6f4b6f9947e6789c
NEOTERM_PKG_DEPENDS="gdk-pixbuf, glib, gtk3, libatkmm-1.6, libc++, libcairomm-1.0, libglibmm-2.4, libpangomm-1.4, libsigc++-2.0"
NEOTERM_PKG_BUILD_DEPENDS="libepoxy"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dbuild-demos=false
-Dbuild-tests=false
"

neoterm_step_post_massage() {
	local _GUARD_FILE="lib/libgtkmm-3.0.so"
	if [ ! -e "${_GUARD_FILE}" ]; then
		neoterm_error_exit "Error: file ${_GUARD_FILE} not found."
	fi
}
