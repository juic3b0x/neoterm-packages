NEOTERM_PKG_HOMEPAGE=https://github.com/open-source-parsers/jsoncpp
NEOTERM_PKG_DESCRIPTION="C++ library for interacting with JSON"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.9.5
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/open-source-parsers/jsoncpp/archive/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=f409856e5920c18d0c2fb85276e24ee607d2a09b5e7d5f0a371368903c275da2
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_BREAKS="jsoncpp-dev"
NEOTERM_PKG_REPLACES="jsoncpp-dev"

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_SHARED_LIBS=ON
-DJSONCPP_WITH_TESTS=OFF
-DCCACHE_FOUND=OFF
"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=25

	local v=$(sed -En 's/^set\(PROJECT_SOVERSION\s+([0-9]+).*/\1/p' \
			CMakeLists.txt)
	if [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}

neoterm_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $NEOTERM_PREFIX.
	if $NEOTERM_ON_DEVICE_BUILD; then
		neoterm_error_exit "Package '$NEOTERM_PKG_NAME' is not safe for on-device builds."
	fi

	# The installation does not overwrite symlinks such as libjsoncpp.so.1,
	# so if rebuilding these are not detected as modified. Fix that:
	rm -f $NEOTERM_PREFIX/lib/libjsoncpp.so*
}
