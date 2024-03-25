NEOTERM_PKG_HOMEPAGE=https://www.cairographics.org/cairomm/
NEOTERM_PKG_DESCRIPTION="Provides a C++ interface to cairo"
NEOTERM_PKG_LICENSE="LGPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.14.4
NEOTERM_PKG_SRCURL=https://www.cairographics.org/releases/cairomm-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=4749d25a2b2ef67cc0c014caaf5c87fa46792fc4b3ede186fb0fc932d2055158
NEOTERM_PKG_DEPENDS="libc++, libcairo, libsigc++-2.0"
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
