NEOTERM_PKG_HOMEPAGE=https://libwebsockets.org
NEOTERM_PKG_DESCRIPTION="Lightweight C websockets library"
NEOTERM_PKG_LICENSE="LGPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="4.3.3"
NEOTERM_PKG_SRCURL=https://github.com/warmcat/libwebsockets/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=6fd33527b410a37ebc91bb64ca51bdabab12b076bc99d153d7c5dd405e4bdf90
NEOTERM_PKG_DEPENDS="openssl, libcap, libuv, zlib"
NEOTERM_PKG_BREAKS="libwebsockets-dev"
NEOTERM_PKG_REPLACES="libwebsockets-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DLWS_WITHOUT_TESTAPPS=ON
-DLWS_WITH_STATIC=OFF
-DLWS_WITH_LIBUV=ON
-DLWS_WITHOUT_EXTENSIONS=OFF
-DLWS_BUILD_HASH=no_hash
"
NEOTERM_PKG_RM_AFTER_INSTALL="lib/pkgconfig/libwebsockets_static.pc"
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=19

	local v=$(sed -En 's/^set\(SOVERSION\s+"?([0-9]+).*/\1/p' \
			CMakeLists.txt)
	if [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}
