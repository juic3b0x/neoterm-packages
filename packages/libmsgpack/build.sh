NEOTERM_PKG_HOMEPAGE=https://github.com/msgpack/msgpack-c/
NEOTERM_PKG_DESCRIPTION="MessagePack implementation for C"
NEOTERM_PKG_LICENSE="BSL-1.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=6.0.0
NEOTERM_PKG_SRCURL=https://github.com/msgpack/msgpack-c/releases/download/c-${NEOTERM_PKG_VERSION}/msgpack-c-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=3654f5e2c652dc52e0a993e270bb57d5702b262703f03771c152bba51602aeba
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
NEOTERM_PKG_BREAKS="libmsgpack-dev"
NEOTERM_PKG_REPLACES="libmsgpack-dev"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DMSGPACK_BUILD_EXAMPLES=OFF
-DMSGPACK_BUILD_TESTS=OFF
"

neoterm_pkg_auto_update() {
	# Get latest release tag:
	local tag
	tag="$(neoterm_github_api_get_tag "${NEOTERM_PKG_SRCURL}")"
	# check if this is not a c++ release:
	if grep -qP "^c-${NEOTERM_PKG_UPDATE_VERSION_REGEXP}\$" <<<"$tag"; then
		neoterm_pkg_upgrade_version "$tag"
	else
		echo "WARNING: Skipping auto-update: Not a C release($tag)"
	fi
}

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=2

	local v=$(sed -En 's/^\s*SET_TARGET_PROPERTIES\s*\(msgpack-c\s+.*\s+SOVERSION\s+([0-9]+).*/\1/p' \
			CMakeLists.txt)
	if [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}
