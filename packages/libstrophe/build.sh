NEOTERM_PKG_HOMEPAGE=https://strophe.im/libstrophe
NEOTERM_PKG_DESCRIPTION="libstrophe is a minimal XMPP library written in C"
NEOTERM_PKG_LICENSE="MIT, GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.13.1"
NEOTERM_PKG_SRCURL=https://github.com/strophe/libstrophe/releases/download/${NEOTERM_PKG_VERSION}/libstrophe-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=a1319f2bbd8e2669359e6a74afa416fa4d52c103b82d89d1e5f56bda3f80cefa
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="openssl, libexpat, c-ares"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--enable-cares"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=0

	local v=$(sed -En 's/^m4_define\(\[v_maj\],\s*\[([0-9]+)\].*/\1/p' \
				configure.ac)
	if [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}

neoterm_step_pre_configure() {
	./bootstrap.sh
}
