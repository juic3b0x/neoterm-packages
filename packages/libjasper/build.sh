NEOTERM_PKG_HOMEPAGE=http://www.ece.uvic.ca/~frodo/jasper/
NEOTERM_PKG_DESCRIPTION="Library for manipulating JPEG-2000 files"
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="LICENSE.txt"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="4.2.2"
NEOTERM_PKG_SRCURL=https://github.com/jasper-software/jasper/archive/refs/tags/version-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=0fb8ad07ea6c06d43567fa5d2592f60c53a2e868fff8b9da1bc2bb950d7dbfe5
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
NEOTERM_PKG_DEPENDS="libjpeg-turbo"
NEOTERM_PKG_BREAKS="libjasper-dev"
NEOTERM_PKG_REPLACES="libjasper-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-H$NEOTERM_PKG_SRCDIR
-B$NEOTERM_PKG_BUILDDIR
-DJAS_STDC_VERSION=201112L
"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=7

	local v="$(sed -En 's/^.*set\(JAS_SO_VERSION ([0-9]+).*$/\1/p' \
			CMakeLists.txt)"
	if [ "${_SOVERSION}" != "${v}" ]; then
		neoterm_error_exit "Error: SOVERSION guard check failed."
	fi
}
