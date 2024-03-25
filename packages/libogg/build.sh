NEOTERM_PKG_HOMEPAGE=https://xiph.org/ogg/
NEOTERM_PKG_DESCRIPTION="Library for working with the Ogg multimedia container format"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.3.5
NEOTERM_PKG_SRCURL=https://github.com/xiph/ogg/releases/download/v${NEOTERM_PKG_VERSION}/libogg-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=c4d91be36fc8e54deae7575241e03f4211eb102afb3fc0775fbbc1b740016705
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BREAKS="libogg-dev"
NEOTERM_PKG_REPLACES="libogg-dev"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=0

	local a
	for a in LIB_CURRENT LIB_AGE; do
		local _${a}=$(sed -En 's/^'"${a}"'=([0-9]+).*/\1/p' \
				configure.ac)
	done
	local v=$(( _LIB_CURRENT - _LIB_AGE ))
	if [ ! "${_LIB_CURRENT}" ] || [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}
