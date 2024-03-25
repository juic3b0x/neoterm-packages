NEOTERM_PKG_HOMEPAGE=https://libsigcplusplus.github.io/libsigcplusplus/
NEOTERM_PKG_DESCRIPTION="Implements a typesafe callback system for standard C++"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
_MAJOR_VERSION=2.12
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.0
NEOTERM_PKG_SRCURL=https://download.gnome.org/sources/libsigc++/${_MAJOR_VERSION}/libsigc++-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=1c466d2e64b34f9b118976eb21b138c37ed124d0f61497df2a90ce6c3d9fa3b5
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
