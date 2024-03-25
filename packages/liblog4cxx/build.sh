NEOTERM_PKG_HOMEPAGE="https://logging.apache.org/log4cxx/latest_stable/index.html"
NEOTERM_PKG_DESCRIPTION="A logging framework for C++ patterned after Apache log4j"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.0.0
NEOTERM_PKG_SRCURL="https://github.com/apache/logging-log4cxx/archive/refs/tags/rel/v$NEOTERM_PKG_VERSION.tar.gz"
NEOTERM_PKG_SHA256=c948a462fd0e04635ffee20527943e84ce4320e8389c3bbf298819a48134b321
NEOTERM_PKG_DEPENDS="apr, apr-util, libc++"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_SHARED_LIBS=ON
-DBUILD_TESTING=OFF
"
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"

neoterm_pkg_auto_update() {
	# Get the newest tag:
	local tag
	tag="$(neoterm_github_api_get_tag "${NEOTERM_PKG_SRCURL}" "${NEOTERM_PKG_UPDATE_TAG_TYPE}")"
	# check if this is not a release:
	if grep -qP "^rel/v${NEOTERM_PKG_UPDATE_VERSION_REGEXP}\$" <<<"$tag"; then
		neoterm_pkg_upgrade_version "$tag"
	else
		echo "WARNING: Skipping auto-update: Not a release($tag)"
	fi
}
