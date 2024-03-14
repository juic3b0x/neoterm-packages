NEOTERM_PKG_HOMEPAGE=https://github.com/rockdaboot/libpsl
NEOTERM_PKG_DESCRIPTION="Public Suffix List library"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.21.5"
NEOTERM_PKG_SRCURL=https://github.com/rockdaboot/libpsl/releases/download/${NEOTERM_PKG_VERSION}/libpsl-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=1dcc9ceae8b128f3c0b3f654decd0e1e891afc6ff81098f227ef260449dae208
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libidn2, libunistring"
NEOTERM_PKG_BREAKS="libpsl-dev"
NEOTERM_PKG_REPLACES="libpsl-dev"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=5

	local e=$(sed -En 's/^([0-9]+):([0-9]+):([0-9]+).*/\1-\3/p' \
			libtool_version_info.txt)
	if [ ! "${e}" ] || [ "${_SOVERSION}" != "$(( "${e}" ))" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}

neoterm_step_pre_configure() {
	autoreconf -fiv
}
