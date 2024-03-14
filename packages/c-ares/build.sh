NEOTERM_PKG_HOMEPAGE=https://c-ares.haxx.se
NEOTERM_PKG_DESCRIPTION="Library for asynchronous DNS requests (including name resolves)"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.27.0"
NEOTERM_PKG_SRCURL=https://github.com/c-ares/c-ares/archive/cares-${NEOTERM_PKG_VERSION//./_}.tar.gz
NEOTERM_PKG_SHA256=de6a839d47b93174ba260187a084027ea681a91ffe12f2d5f20645652eae246c
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+.\d+.\d+"
NEOTERM_PKG_DEPENDS="resolv-conf"
NEOTERM_PKG_BREAKS="c-ares-dev"
NEOTERM_PKG_REPLACES="c-ares-dev"
# Build with cmake to install cmake/c-ares/*.cmake files:
NEOTERM_PKG_FORCE_CMAKE=true
NEOTERM_PKG_RM_AFTER_INSTALL="bin/"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=2

	local e=$(sed -En 's/^\s*SET\s*\(CARES_LIB_VERSIONINFO\s+"?([0-9]+):([0-9]+):([0-9]+).*/\1-\3/p' \
			CMakeLists.txt)
	if [ ! "${e}" ] || [ "${_SOVERSION}" != "$(( "${e}" ))" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}
