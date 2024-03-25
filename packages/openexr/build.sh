NEOTERM_PKG_HOMEPAGE=https://www.openexr.com/
NEOTERM_PKG_DESCRIPTION="Provides the specification and reference implementation of the EXR file format"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="3.2.1"
NEOTERM_PKG_SRCURL=https://github.com/AcademySoftwareFoundation/openexr/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=61e175aa2203399fb3c8c2288752fbea3c2637680d50b6e306ea5f8ffdd46a9b
NEOTERM_PKG_DEPENDS="imath, libc++, zlib"
NEOTERM_PKG_CONFLICTS="openexr2"
NEOTERM_PKG_REPLACES="openexr2"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_TESTING=OFF
"

neoterm_step_pre_configure() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=31
	local v=$(sed -En 's/^set\(OPENEXR_LIB_SOVERSION\s+([0-9]+).*/\1/p' CMakeLists.txt)
	if [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}

neoterm_step_post_massage() {
	shopt -s nullglob
	local f
	for f in lib/libImath*; do
		neoterm_error_exit "File ${f} should not be contained in this package."
	done
	shopt -u nullglob
}
