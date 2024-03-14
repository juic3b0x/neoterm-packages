NEOTERM_PKG_HOMEPAGE=https://tls.mbed.org/
NEOTERM_PKG_DESCRIPTION="Light-weight cryptographic and SSL/TLS library"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_SRCURL=git+https://github.com/ARMmbed/mbedtls
NEOTERM_PKG_VERSION="3.5.2"
NEOTERM_PKG_GIT_BRANCH=mbedtls-$NEOTERM_PKG_VERSION
NEOTERM_PKG_BREAKS="mbedtls-dev"
NEOTERM_PKG_REPLACES="mbedtls-dev"
NEOTERM_PKG_AUTO_UPDATE=true

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DUSE_STATIC_MBEDTLS_LIBRARY=OFF
-DUSE_SHARED_MBEDTLS_LIBRARY=ON
-DENABLE_TESTING=OFF
-DENABLE_PROGRAMS=OFF
"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVER_crypto=15
	local _SOVER_tls=20
	local _SOVER_x509=6

	local f
	for f in crypto tls x509; do
		local v="$(sed -n 's/^SOEXT_'${f^^}'?=so\.//p' library/Makefile)"
		if [ "$(eval echo \$_SOVER_${f})" != "${v}" ]; then
			neoterm_error_exit "Error: SOVERSION guard check failed for libmbed${f}.so."
		fi
	done
}

neoterm_step_pre_configure() {
	if [ "$NEOTERM_ARCH" = "i686" ]; then
		scripts/config.py unset MBEDTLS_AESNI_C
	fi
}
