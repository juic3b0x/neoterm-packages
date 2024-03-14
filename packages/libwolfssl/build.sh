NEOTERM_PKG_HOMEPAGE=https://www.wolfssl.com/
NEOTERM_PKG_DESCRIPTION="A small, fast, portable implementation of TLS/SSL for embedded devices to the cloud"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="5.6.6"
NEOTERM_PKG_SRCURL=https://github.com/wolfSSL/wolfssl/archive/refs/tags/v${NEOTERM_PKG_VERSION}-stable.tar.gz
NEOTERM_PKG_SHA256=3d2ca672d41c2c2fa667885a80d6fa03c3e91f0f4f72f87aef2bc947e8c87237
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"

neoterm_step_pre_configure() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=42

	local a
	for a in LIBTOOL_CURRENT LIBTOOL_AGE; do
		local _${a}=$(sed -En 's/^set\('"${a}"'\s+([0-9]+).*/\1/p' \
				CMakeLists.txt)
	done
	local v=$(( _LIBTOOL_CURRENT - _LIBTOOL_AGE ))
	if [ ! "${_LIBTOOL_CURRENT}" ] || [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}
