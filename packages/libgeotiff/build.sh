NEOTERM_PKG_HOMEPAGE="https://github.com/OSGeo/libgeotiff"
NEOTERM_PKG_DESCRIPTION="Library for handling TIFF for georeferenced raster imagery"
NEOTERM_PKG_GROUPS="science"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_LICENSE_FILE="LICENSE"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.7.1"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL="https://github.com/OSGeo/libgeotiff/archive/refs/tags/$NEOTERM_PKG_VERSION.tar.gz"
NEOTERM_PKG_SHA256=09a0cae5352030011b994a60237743a1327ab95ce482318d45bf9fcb5e5f76b5
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libtiff, proj"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DWITH_TIFF=ON
-DWITH_TOWGS84=ON
-DBUILD_SHARED_LIBS=ON
"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=5

	local e=$(sed -En 's/^libgeotiff_la_LDFLAGS\s*=.*\s+-version-info\s+([0-9]+):([0-9]+):([0-9]+).*/\1-\3/p' \
			libgeotiff/Makefile.am)
	if [ ! "${e}" ] || [ "${_SOVERSION}" != "$(( "${e}" ))" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}

neoterm_step_pre_configure() {
	NEOTERM_PKG_SRCDIR+="/libgeotiff"
}
