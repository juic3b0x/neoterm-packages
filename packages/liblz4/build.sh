NEOTERM_PKG_HOMEPAGE=https://lz4.github.io/lz4/
NEOTERM_PKG_DESCRIPTION="Fast LZ compression algorithm library"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.9.4
NEOTERM_PKG_SRCURL=https://github.com/lz4/lz4/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=0b0e3aa07c8c063ddf40b082bdf7e37a1562bda40a0ff5272957f3e987e0e54b
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BREAKS="liblz4-dev"
NEOTERM_PKG_REPLACES="liblz4-dev"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=1

	local v=$(sed -En 's/^#define LZ4_VERSION_MAJOR +([0-9]+) +.*$/\1/p' \
			lib/lz4.h)
	if [ "${_SOVERSION}" != "${v}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}

neoterm_step_pre_configure() {
	NEOTERM_PKG_SRCDIR+=/build/cmake
}
