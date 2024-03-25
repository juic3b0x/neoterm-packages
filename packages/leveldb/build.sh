NEOTERM_PKG_HOMEPAGE=https://github.com/google/leveldb
NEOTERM_PKG_DESCRIPTION="Fast key-value storage library"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.23
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://github.com/google/leveldb/archive/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=9a37f8a6174f09bd622bc723b55881dc541cd50747cbd08831c2a82d620f6d76
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_BREAKS="leveldb-dev"
NEOTERM_PKG_REPLACES="leveldb-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_SHARED_LIBS=TRUE
-DLEVELDB_BUILD_TESTS=OFF
-DLEVELDB_BUILD_BENCHMARKS=OFF
"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=1

	local v=$(echo ${NEOTERM_PKG_VERSION#*:} | cut -d . -f 1)
	if [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}
