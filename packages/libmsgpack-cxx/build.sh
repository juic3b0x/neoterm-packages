NEOTERM_PKG_HOMEPAGE=https://msgpack.org/
NEOTERM_PKG_DESCRIPTION="msgpack for C++"
NEOTERM_PKG_LICENSE="BSL-1.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="6.1.0"
NEOTERM_PKG_SRCURL=https://github.com/msgpack/msgpack-c/releases/download/cpp-${NEOTERM_PKG_VERSION}/msgpack-cxx-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=23ede7e93c8efee343ad8c6514c28f3708207e5106af3b3e4969b3a9ed7039e7
NEOTERM_PKG_BUILD_DEPENDS="boost, boost-headers"
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"

neoterm_pkg_auto_update() {
	# Get latest release tag:
	local tag
	tag="$(neoterm_github_api_get_tag "${NEOTERM_PKG_SRCURL}")"
	# check if this is not a c release:
	if grep -qP "^cpp-${NEOTERM_PKG_UPDATE_VERSION_REGEXP}\$" <<<"$tag"; then
		neoterm_pkg_upgrade_version "$tag"
	else
		echo "WARNING: Skipping auto-update: Not a cpp release($tag)"
	fi
}
