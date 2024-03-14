NEOTERM_PKG_HOMEPAGE=https://libxlsxwriter.github.io/
NEOTERM_PKG_DESCRIPTION="A C library for creating Excel XLSX files"
NEOTERM_PKG_LICENSE="BSD 2-Clause, BSD 3-Clause, ZLIB, MPL-2.0, MIT, Public Domain"
NEOTERM_PKG_LICENSE_FILE="License.txt"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.1.5
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/jmcnamara/libxlsxwriter/archive/refs/tags/RELEASE_${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=12843587d591cf679e6ec63ecc629245befec2951736804a837696cdb5d61946
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+.\d+.\d+"
NEOTERM_PKG_DEPENDS="libminizip"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_SHARED_LIBS=ON
-DUSE_SYSTEM_MINIZIP=ON
"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=5

	local v=$(sed -En 's/.*LXW_SOVERSION .*"(.*)".*/\1/p' \
			include/xlsxwriter.h)
	if [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}
