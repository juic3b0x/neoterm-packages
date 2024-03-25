NEOTERM_PKG_HOMEPAGE=https://libsigcplusplus.github.io/libsigcplusplus/
NEOTERM_PKG_DESCRIPTION="Implements a typesafe callback system for standard C++"
NEOTERM_PKG_LICENSE="LGPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
_MAJOR_VERSION=3.4
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.0
NEOTERM_PKG_SRCURL=https://download.gnome.org/sources/libsigc++/${_MAJOR_VERSION}/libsigc++-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=02e2630ffb5ce93cd52c38423521dfe7063328863a6e96d41d765a6116b8707e
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dbuild-examples=false
"

neoterm_step_post_massage() {
	local _GUARD_FILE="lib/${NEOTERM_PKG_NAME/++/}.so"
	if [ ! -e "${_GUARD_FILE}" ]; then
		neoterm_error_exit "Error: file ${_GUARD_FILE} not found."
	fi
}
