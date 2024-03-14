NEOTERM_PKG_HOMEPAGE=http://www.underbit.com/products/mad/
NEOTERM_PKG_DESCRIPTION="MAD is a high-quality MPEG audio decoder"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.16.4"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://codeberg.org/tenacityteam/libmad/archive/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=f4eb229452252600ce48f3c2704c9e6d97b789f81e31c37b0c67dd66f445ea35
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BREAKS="libmad-dev"
NEOTERM_PKG_REPLACES="libmad-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
"

neoterm_step_post_massage() {
	local _GUARD_FILE="lib/libmad.so.0"
	if [ ! -e "${_GUARD_FILE}" ]; then
		neoterm_error_exit "Error: file ${_GUARD_FILE} not found."
	fi
}
