NEOTERM_PKG_HOMEPAGE=https://github.com/google/double-conversion
NEOTERM_PKG_DESCRIPTION="Binary-decimal and decimal-binary routines for IEEE doubles"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="3.3.0"
NEOTERM_PKG_SRCURL=https://github.com/google/double-conversion/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=04ec44461850abbf33824da84978043b22554896b552c5fd11a9c5ae4b4d296e
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="-DBUILD_SHARED_LIBS=ON"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=3

	local v=$(sed -En 's/^\s*set_target_properties\(double-conversion\s+.*\s+SOVERSION\s+([0-9]+).*/\1/p' \
			CMakeLists.txt)
	if [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}
