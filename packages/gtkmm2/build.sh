NEOTERM_PKG_HOMEPAGE=https://www.gtkmm.org/
NEOTERM_PKG_DESCRIPTION="The C++ API for GTK"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
_MAJOR_VERSION=2.24
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.5
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://download.gnome.org/sources/gtkmm/${_MAJOR_VERSION}/gtkmm-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=0680a53b7bf90b4e4bf444d1d89e6df41c777e0bacc96e9c09fc4dd2f5fe6b72
NEOTERM_PKG_DEPENDS="gdk-pixbuf, glib, gtk2, libatkmm-1.6, libc++, libcairomm-1.0, libglibmm-2.4, libpangomm-1.4, libsigc++-2.0"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-documentation
"

neoterm_step_pre_configure() {
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}

neoterm_step_post_massage() {
	local _GUARD_FILE="lib/libgtkmm-2.4.so"
	if [ ! -e "${_GUARD_FILE}" ]; then
		neoterm_error_exit "Error: file ${_GUARD_FILE} not found."
	fi
}
