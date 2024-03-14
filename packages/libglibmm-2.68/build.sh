NEOTERM_PKG_HOMEPAGE=https://www.gtkmm.org/
NEOTERM_PKG_DESCRIPTION="A C++ API for parts of glib that are useful for C++"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
_MAJOR_VERSION=2.76
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.0
NEOTERM_PKG_SRCURL=https://download.gnome.org/sources/glibmm/${_MAJOR_VERSION}/glibmm-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=8637d80ceabd94fddd6e48970a082a264558d4ab82684e15ffc87e7ef3462ab2
NEOTERM_PKG_DEPENDS="glib, libc++, libsigc++-3.0"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dbuild-examples=false
"

neoterm_step_post_massage() {
	local _GUARD_FILE="lib/${NEOTERM_PKG_NAME}.so"
	if [ ! -e "${_GUARD_FILE}" ]; then
		neoterm_error_exit "Error: file ${_GUARD_FILE} not found."
	fi
}
