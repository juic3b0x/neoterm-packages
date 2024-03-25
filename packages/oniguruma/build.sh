NEOTERM_PKG_HOMEPAGE=https://github.com/kkos/oniguruma
NEOTERM_PKG_DESCRIPTION="Regular expressions library"
NEOTERM_PKG_VERSION="6.9.9"
NEOTERM_PKG_SRCURL=https://github.com/kkos/oniguruma/releases/download/v$NEOTERM_PKG_VERSION/onig-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=60162bd3b9fc6f4886d4c7a07925ffd374167732f55dce8c491bfd9cd818a6cf
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_LICENSE="BSD"
NEOTERM_PKG_MAINTAINER="@neoterm"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=5

	local e=$(sed -En 's/^LTVERSION="?([0-9]+):([0-9]+):([0-9]+).*/\1-\3/p' \
			configure.ac)
	if [ ! "${e}" ] || [ "${_SOVERSION}" != "$(( "${e}" ))" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}
