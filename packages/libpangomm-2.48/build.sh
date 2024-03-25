NEOTERM_PKG_HOMEPAGE=https://www.gtkmm.org/
NEOTERM_PKG_DESCRIPTION="A C++ API for Pango"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
_MAJOR_VERSION=2.50
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.1
NEOTERM_PKG_SRCURL=https://download.gnome.org/sources/pangomm/${_MAJOR_VERSION}/pangomm-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=ccc9923413e408c2bff637df663248327d72822f11e394b423e1c5652b7d9214
NEOTERM_PKG_DEPENDS="glib, libc++, libcairomm-1.16, libglibmm-2.68, libsigc++-3.0, pango"

neoterm_step_post_massage() {
	local _GUARD_FILE="lib/${NEOTERM_PKG_NAME}.so"
	if [ ! -e "${_GUARD_FILE}" ]; then
		neoterm_error_exit "Error: file ${_GUARD_FILE} not found."
	fi
}
