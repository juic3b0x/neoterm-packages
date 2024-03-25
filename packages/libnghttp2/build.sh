NEOTERM_PKG_HOMEPAGE=https://nghttp2.org/
NEOTERM_PKG_DESCRIPTION="nghttp HTTP 2.0 library"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.60.0"
NEOTERM_PKG_SRCURL=https://github.com/nghttp2/nghttp2/releases/download/v${NEOTERM_PKG_VERSION}/nghttp2-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=625d6c3da1d9ca4fd643a638256431ae68fd1901653b2a61a245eea7b261bf4e
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BREAKS="libnghttp2-dev"
NEOTERM_PKG_REPLACES="libnghttp2-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--enable-lib-only"
# The tools are not built due to --enable-lib-only:
NEOTERM_PKG_RM_AFTER_INSTALL="share/man/man1 share/nghttp2/fetch-ocsp-response"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=14

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
