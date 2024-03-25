NEOTERM_PKG_HOMEPAGE=https://github.com/librsync/librsync
NEOTERM_PKG_DESCRIPTION="Remote delta-compression library"
NEOTERM_PKG_LICENSE="LGPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.3.4"
NEOTERM_PKG_SRCURL=https://github.com/librsync/librsync/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=a0dedf9fff66d8e29e7c25d23c1f42beda2089fb4eac1b36e6acd8a29edfbd1f
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libbz2"
NEOTERM_PKG_BUILD_DEPENDS="libpopt"
NEOTERM_PKG_BREAKS="librsync-dev"
NEOTERM_PKG_REPLACES="librsync-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="-DPERL_EXECUTABLE=$(command -v perl)"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=2

	local v=$(echo ${NEOTERM_PKG_VERSION#*:} | cut -d . -f 1)
	if [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}
