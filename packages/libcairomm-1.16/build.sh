NEOTERM_PKG_HOMEPAGE=https://www.cairographics.org/cairomm/
NEOTERM_PKG_DESCRIPTION="Provides a C++ interface to cairo"
NEOTERM_PKG_LICENSE="LGPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.16.2
NEOTERM_PKG_SRCURL=https://www.cairographics.org/releases/cairomm-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=6a63bf98a97dda2b0f55e34d1b5f3fb909ef8b70f9b8d382cb1ff3978e7dc13f
NEOTERM_PKG_DEPENDS="libc++, libcairo, libsigc++-3.0"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dbuild-examples=false
-Dbuild-tests=false
-Dboost-shared=true
"

neoterm_step_post_massage() {
	local _GUARD_FILE="lib/${NEOTERM_PKG_NAME}.so"
	if [ ! -e "${_GUARD_FILE}" ]; then
		neoterm_error_exit "Error: file ${_GUARD_FILE} not found."
	fi
}
