NEOTERM_PKG_HOMEPAGE=https://www.gtkmm.org/
NEOTERM_PKG_DESCRIPTION="A C++ API for Pango"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
_MAJOR_VERSION=2.46
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.3
NEOTERM_PKG_SRCURL=https://download.gnome.org/sources/pangomm/${_MAJOR_VERSION}/pangomm-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=410fe04d471a608f3f0273d3a17d840241d911ed0ff2c758a9859c66c6f24379
NEOTERM_PKG_DEPENDS="glib, libc++, libcairomm-1.0, libglibmm-2.4, libsigc++-2.0, pango"

neoterm_step_post_massage() {
	local _GUARD_FILE="lib/${NEOTERM_PKG_NAME}.so"
	if [ ! -e "${_GUARD_FILE}" ]; then
		neoterm_error_exit "Error: file ${_GUARD_FILE} not found."
	fi
}
