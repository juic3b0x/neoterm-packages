NEOTERM_PKG_HOMEPAGE=https://libzip.org/
NEOTERM_PKG_DESCRIPTION="Library for reading, creating, and modifying zip archives"
NEOTERM_PKG_LICENSE="BSD"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.10.1"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/nih-at/libzip/releases/download/v$NEOTERM_PKG_VERSION/libzip-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=9669ae5dfe3ac5b3897536dc8466a874c8cf2c0e3b1fdd08d75b273884299363
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libbz2, liblzma, openssl, zlib, zstd"
NEOTERM_PKG_BREAKS="libzip-dev"
NEOTERM_PKG_REPLACES="libzip-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DENABLE_GNUTLS=NO
-DENABLE_MBEDTLS=NO
-DENABLE_OPENSSL=YES
"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=5

	local v=$(sed -En 's/^\s*set_target_properties\(zip\s+.*\s+SOVERSION\s+([0-9]+).*/\1/p' \
			lib/CMakeLists.txt)
	if [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}
