NEOTERM_PKG_HOMEPAGE=https://github.com/zlib-ng/minizip-ng
NEOTERM_PKG_DESCRIPTION="A zip manipulation library written in C"
NEOTERM_PKG_LICENSE="ZLIB"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="4.0.5"
NEOTERM_PKG_SRCURL=https://github.com/zlib-ng/minizip-ng/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=9bb636474b8a4269280d32aca7de4501f5c24cc642c9b4225b4ed7b327f4ee73
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libbz2, libiconv, liblzma, openssl, zlib"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_INSTALL_INCLUDEDIR=include/minizip-ng
-DBUILD_SHARED_LIBS=ON
-DMZ_COMPAT=OFF
"
# ZSTD is disabled only because it breaks build of opencolorio when enabled.
# This may be resolved by building zstd with CMake, but that needs extra care
# such as SONAME change. I just cannot be bothered to do that for now.
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" -DMZ_ZSTD=OFF"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=4

	local v=$(sed -En 's/^set\(SOVERSION\s+"?([0-9]+).*/\1/p' \
			CMakeLists.txt)
	if [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}
