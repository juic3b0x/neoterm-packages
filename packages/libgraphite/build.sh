NEOTERM_PKG_HOMEPAGE=https://github.com/silnrsi/graphite
NEOTERM_PKG_DESCRIPTION="Font system for multiple languages"
NEOTERM_PKG_LICENSE="LGPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.3.14
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://github.com/silnrsi/graphite/archive/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=7a3b342c5681921ce2e0c2496509d30b5b078399d5a7bd2358f95166d57d91df
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_BREAKS="libgraphite-dev"
NEOTERM_PKG_REPLACES="libgraphite-dev"
NEOTERM_PKG_RM_AFTER_INSTALL="bin/gr2fonttest"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=3

	local v=$(sed -En 's/^set\(GRAPHITE_API_CURRENT\s+([0-9]+).*/\1/p' \
			src/CMakeLists.txt)
	if [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}
