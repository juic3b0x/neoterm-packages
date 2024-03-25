NEOTERM_PKG_HOMEPAGE=https://github.com/lipnitsk/libcue/
NEOTERM_PKG_DESCRIPTION="CUE Sheet Parser Library"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.3.0"
NEOTERM_PKG_SRCURL=https://github.com/lipnitsk/libcue/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=cc1b3a65c60bd88b77a1ddd1574042d83cf7cc32b85fe9481c99613359eb7cfe
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BREAKS="libcue-dev"
NEOTERM_PKG_REPLACES="libcue-dev"
# To avoid picking up cross-compiled flex and bison:
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DBISON_EXECUTABLE=$(command -v bison)
-DFLEX_EXECUTABLE=$(command -v flex)
-DBUILD_SHARED_LIBS=ON
"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=2

	local v=$(sed -En 's/^SET\(PACKAGE_SOVERSION\s+([0-9]+).*/\1/p' \
			CMakeLists.txt)
	if [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}
