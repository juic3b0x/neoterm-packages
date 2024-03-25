NEOTERM_PKG_HOMEPAGE=https://www.gtkmm.org/
NEOTERM_PKG_DESCRIPTION="A C++ API for parts of glib that are useful for C++"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
_MAJOR_VERSION=2.66
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.6
NEOTERM_PKG_SRCURL=https://download.gnome.org/sources/glibmm/${_MAJOR_VERSION}/glibmm-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=5358742598181e5351d7bf8da072bf93e6dd5f178d27640d4e462bc8f14e152f
NEOTERM_PKG_DEPENDS="glib, libc++, libsigc++-2.0"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dbuild-examples=false
"

neoterm_step_post_massage() {
	local _GUARD_FILE="lib/${NEOTERM_PKG_NAME}.so"
	if [ ! -e "${_GUARD_FILE}" ]; then
		neoterm_error_exit "Error: file ${_GUARD_FILE} not found."
	fi
}
