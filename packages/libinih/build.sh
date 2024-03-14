NEOTERM_PKG_HOMEPAGE=https://github.com/benhoyt/inih
NEOTERM_PKG_DESCRIPTION="A simple .INI file parser written in C"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="58"
NEOTERM_PKG_SRCURL=https://github.com/benhoyt/inih/archive/refs/tags/r${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=e79216260d5dffe809bda840be48ab0eec7737b2bb9f02d2275c1b46344ea7b7
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+"
NEOTERM_PKG_DEPENDS="libc++"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=0

	local v=$(sed -n "/library('inih'/,/)\s*$/p" meson.build | \
			 sed -En "s/\s*soversion\s*:\s*'?([0-9]+).*/\1/p")
	if [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}
