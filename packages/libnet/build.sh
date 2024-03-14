NEOTERM_PKG_HOMEPAGE=https://github.com/libnet/libnet
NEOTERM_PKG_DESCRIPTION="A library which provides API for commonly used low-level net functions"
NEOTERM_PKG_LICENSE="BSD 2-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.3"
NEOTERM_PKG_SRCURL=https://github.com/libnet/libnet/releases/download/v$NEOTERM_PKG_VERSION/libnet-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=ad1e2dd9b500c58ee462acd839d0a0ea9a2b9248a1287840bc601e774fb6b28f
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=9

	local e=$(sed -En 's/^libnet_la_LDFLAGS\s*=.*\s+-version-info\s+([0-9]+):([0-9]+):([0-9]+).*/\1-\3/p' \
			src/Makefile.am)
	if [ ! "${e}" ] || [ "${_SOVERSION}" != "$(( "${e}" ))" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}
