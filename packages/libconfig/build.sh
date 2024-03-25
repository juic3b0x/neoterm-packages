NEOTERM_PKG_HOMEPAGE=https://github.com/hyperrealm/libconfig
NEOTERM_PKG_DESCRIPTION="C/C++ Configuration File Library"
NEOTERM_PKG_LICENSE="LGPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.7.3
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://github.com/hyperrealm/libconfig/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=68757e37c567fd026330c8a8449aa5f9cac08a642f213f2687186b903bd7e94e
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_BREAKS="libconfig-dev"
NEOTERM_PKG_REPLACES="libconfig-dev"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=11

	local e=$(sed -En 's/^VERINFO\s*=\s*-version-info\s+([0-9]+):([0-9]+):([0-9]+).*/\1-\3/p' \
			lib/Makefile.am)
	if [ ! "${e}" ] || [ "${_SOVERSION}" != "$(( "${e}" ))" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}

neoterm_step_pre_configure() {
	autoreconf -fi

	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
