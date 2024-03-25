NEOTERM_PKG_HOMEPAGE=https://libsodium.org/
NEOTERM_PKG_DESCRIPTION="Network communication, cryptography and signaturing library"
NEOTERM_PKG_LICENSE="ISC"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.0.19"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/jedisct1/libsodium/archive/${NEOTERM_PKG_VERSION}-RELEASE.tar.gz
NEOTERM_PKG_SHA256=4fb996013283f482f46a457c8ff2c1495e797788e78e8ec56b1aa1b19253bf75
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
NEOTERM_PKG_BREAKS="libsodium-dev"
NEOTERM_PKG_REPLACES="libsodium-dev"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=26

	local e=$(sed -En 's/^SODIUM_LIBRARY_VERSION=([0-9]+):([0-9]+):([0-9]+).*/\1-\3/p' \
				configure.ac)
	if [ ! "${e}" ] || [ "${_SOVERSION}" != "$(( "${e}" ))" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}

neoterm_step_pre_configure() {
	if [ "$NEOTERM_ARCH" = "aarch64" ]; then
		export CFLAGS_ARMCRYPTO="-march=armv8-a+crypto+aes"
	fi
}
