NEOTERM_PKG_HOMEPAGE=https://github.com/martinh/libconfuse
NEOTERM_PKG_DESCRIPTION="Small configuration file parser library for C"
NEOTERM_PKG_LICENSE="LGPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.3
NEOTERM_PKG_SRCURL=https://github.com/martinh/libconfuse/releases/download/v$NEOTERM_PKG_VERSION/confuse-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=3a59ded20bc652eaa8e6261ab46f7e483bc13dad79263c15af42ecbb329707b8
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BREAKS="libconfuse-dev"
NEOTERM_PKG_REPLACES="libconfuse-dev"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=2

	local e=$(sed -En 's/^libconfuse_la_LDFLAGS\s*=.*\s+-version-info\s+([0-9]+):([0-9]+):([0-9]+).*/\1-\3/p' \
			src/Makefile.am)
	if [ ! "${e}" ] || [ "${_SOVERSION}" != "$(( "${e}" ))" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}
