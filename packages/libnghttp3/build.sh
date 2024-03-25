NEOTERM_PKG_HOMEPAGE=https://nghttp2.org/nghttp3/
NEOTERM_PKG_DESCRIPTION="HTTP/3 library written in C"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.2.0"
NEOTERM_PKG_SRCURL=https://github.com/ngtcp2/nghttp3/releases/download/v${NEOTERM_PKG_VERSION}/nghttp3-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=d2e216bae7bd7362f850922e4237a5caa204853b3594b22adccab4c1e1c1d1aa
NEOTERM_PKG_ESSENTIAL=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--enable-lib-only"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=9

	local a
	for a in LT_CURRENT LT_AGE; do
		local _${a}=$(sed -En 's/^AC_SUBST\('"${a}"',\s*([0-9]+).*/\1/p' \
				configure.ac)
	done
	local v=$(( _LT_CURRENT - _LT_AGE ))
	if [ ! "${_LT_CURRENT}" ] || [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}

neoterm_step_pre_configure() {
	autoreconf -fi
}
