NEOTERM_PKG_HOMEPAGE=https://openzim.org
NEOTERM_PKG_DESCRIPTION="The ZIM library is the reference implementation for the ZIM file format."
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="9.1.0"
NEOTERM_PKG_SRCURL=https://github.com/openzim/libzim/archive/$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=faf19a35882415212d46a51aab45692ccfa1e2e36beb7261eec1ec53e29b9e6a
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libc++, libicu, liblzma, libxapian, zstd"
NEOTERM_PKG_BUILD_DEPENDS="googletest, libuuid"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=9

	local v=$(echo ${NEOTERM_PKG_VERSION#*:} | cut -d . -f 1)
	if [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed." 
	fi
}
