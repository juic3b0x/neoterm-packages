NEOTERM_PKG_HOMEPAGE=https://curl.se/
NEOTERM_PKG_DESCRIPTION="Easy-to-use client-side URL transfer library"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="8.6.0"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/curl/curl/releases/download/curl-${NEOTERM_PKG_VERSION//./_}/curl-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=3ccd55d91af9516539df80625f818c734dc6f2ecf9bada33c76765e99121db15
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+.\d+.\d+"
NEOTERM_PKG_DEPENDS="libnghttp2, libnghttp3, libssh2, openssl (>= 1:3.2.1-1), zlib"
NEOTERM_PKG_BREAKS="libcurl-dev"
NEOTERM_PKG_REPLACES="libcurl-dev"
NEOTERM_PKG_ESSENTIAL=true

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-ntlm-wb=$NEOTERM_PREFIX/bin/ntlm_auth
--with-ca-bundle=$NEOTERM_PREFIX/etc/tls/cert.pem
--with-ca-path=$NEOTERM_PREFIX/etc/tls/certs
--with-nghttp2
--without-libidn
--without-libidn2
--without-librtmp
--without-brotli
--without-libpsl
--with-libssh2
--with-ssl
--with-openssl
--with-openssl-quic
--with-nghttp3
"

# https://github.com/juic3b0x/neoterm-packages/issues/15889
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_func_getpwuid=yes"

# Starting with version 7.62 curl started enabling http/2 by default.
# Support for http/2 as added in version 1.4.8-8 of the apt package, so we
# conflict with previous versions to avoid broken installations.
NEOTERM_PKG_CONFLICTS="apt (<< 1.4.8-8)"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=4

	local a
	for a in VERSIONCHANGE VERSIONDEL; do
		local _${a}=$(sed -En 's/^'"${a}"'=([0-9]+).*/\1/p' \
				lib/Makefile.soname)
	done
	local v=$(( _VERSIONCHANGE - _VERSIONDEL ))
	if [ ! "${_VERSIONCHANGE}" ] || [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}

neoterm_step_pre_configure() {
	LDFLAGS+=" -Wl,-z,nodelete"
}
