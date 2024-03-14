NEOTERM_PKG_HOMEPAGE=https://proj.org
NEOTERM_PKG_DESCRIPTION="Generic coordinate transformation software"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="Henrik Grimler @Grimler91"
NEOTERM_PKG_VERSION="9.4.0"
NEOTERM_PKG_SRCURL=https://github.com/OSGeo/proj.4/archive/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=62623fb6618e2a921394013b1d00094c9aadcd39d7cff859de68f74f34602056
NEOTERM_PKG_DEPENDS="libc++, libsqlite, sqlite, libtiff, libcurl"
NEOTERM_PKG_BREAKS="proj-dev"
NEOTERM_PKG_REPLACES="proj-dev"
NEOTERM_PKG_GROUPS="science"
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=25

	local v=$(sed -En 's/^set\(PROJ_SOVERSION\s+([0-9]+).*/\1/p' \
			CMakeLists.txt)
	if [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}
