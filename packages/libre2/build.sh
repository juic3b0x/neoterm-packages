NEOTERM_PKG_HOMEPAGE=https://github.com/google/re2
NEOTERM_PKG_DESCRIPTION="A regular expression library"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2024.03.01"
NEOTERM_PKG_SRCURL=https://github.com/google/re2/releases/download/${NEOTERM_PKG_VERSION//./-}/re2-${NEOTERM_PKG_VERSION//./-}.tar.gz
NEOTERM_PKG_SHA256=7b2b3aa8241eac25f674e5b5b2e23d4ac4f0a8891418a2661869f736f03f57f4
NEOTERM_PKG_DEPENDS="abseil-cpp, libc++"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="-DBUILD_SHARED_LIBS=ON"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=11

	local v=$(sed -E -n 's/^SONAME=([0-9]+)$/\1/p' Makefile)
	if [ "${_SOVERSION}" != "${v}" ]; then
		neoterm_error_exit "Error: SOVERSION guard check failed."
	fi
}
