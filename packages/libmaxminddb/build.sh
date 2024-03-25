NEOTERM_PKG_HOMEPAGE=https://dev.maxmind.com/geoip/geoip2/
NEOTERM_PKG_DESCRIPTION="MaxMind GeoIP2 database - library and utilities"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.9.1"
NEOTERM_PKG_SRCURL=https://github.com/maxmind/libmaxminddb/archive/$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=6087d5ecb93e5223da7f08067bd8cd97c3b155a6bb99a0c710fc86cf0c3c246b
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BREAKS="libmaxminddb-dev"
NEOTERM_PKG_REPLACES="libmaxminddb-dev"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--disable-tests"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=0.0.7

	local v=$(sed -En 's/^set\(MAXMINDDB_SOVERSION\s+([0-9.]+).*/\1/p' \
			CMakeLists.txt)
	if [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}

neoterm_step_pre_configure() {
	./bootstrap
}
