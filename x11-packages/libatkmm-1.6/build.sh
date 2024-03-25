NEOTERM_PKG_HOMEPAGE=https://www.gtkmm.org/
NEOTERM_PKG_DESCRIPTION="The C++ binding for the ATK library"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
_MAJOR_VERSION=2.28
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.3
NEOTERM_PKG_SRCURL=https://download.gnome.org/sources/atkmm/${_MAJOR_VERSION}/atkmm-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=7c2088b486a909be8da2b18304e56c5f90884d1343c8da7367ea5cd3258b9969
NEOTERM_PKG_DEPENDS="atk, glib, libc++, libglibmm-2.4, libsigc++-2.0"

neoterm_step_post_massage() {
	local _GUARD_FILE="lib/${NEOTERM_PKG_NAME}.so"
	if [ ! -e "${_GUARD_FILE}" ]; then
		neoterm_error_exit "Error: file ${_GUARD_FILE} not found."
	fi
}
