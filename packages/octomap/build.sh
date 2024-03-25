NEOTERM_PKG_HOMEPAGE="https://github.com/OctoMap/octomap"
NEOTERM_PKG_DESCRIPTION="An efficient probabilistic 3D mapping framework based on octrees"
NEOTERM_PKG_GROUPS="science"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_LICENSE_FILE="octomap/LICENSE.txt"
NEOTERM_PKG_MAINTAINER="Pooya Moradi <pvonmoradi@gmail.com>"
NEOTERM_PKG_VERSION="1.9.8"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL="https://github.com/OctoMap/octomap/archive/refs/tags/v$NEOTERM_PKG_VERSION.tar.gz"
NEOTERM_PKG_SHA256=417af6da4e855e9a83b93458aa98b01a2c88f880088baad2b59d323ce162586e
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_FORCE_CMAKE=true

# disable GUI subprojects
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_OCTOVIS_SUBPROJECT=OFF
-DBUILD_DYNAMICETD3D_SUBPROJECT=ON
-DOCTOVIS_QT5=OFF
"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=1.9

	local v=$(echo ${NEOTERM_PKG_VERSION#*:} | cut -d . -f 1-2)
	if [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}
