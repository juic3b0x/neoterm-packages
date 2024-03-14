NEOTERM_PKG_HOMEPAGE=https://stedolan.github.io/jq/
NEOTERM_PKG_DESCRIPTION="Command-line JSON processor"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.7.1"
NEOTERM_PKG_SRCURL=https://github.com/stedolan/jq/releases/download/jq-$NEOTERM_PKG_VERSION/jq-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=478c9ca129fd2e3443fe27314b455e211e0d8c60bc8ff7df703873deeee580c2
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+(\.\d+)?"
NEOTERM_PKG_DEPENDS="oniguruma"
NEOTERM_PKG_BREAKS="jq-dev"
NEOTERM_PKG_REPLACES="jq-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--with-oniguruma"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=1

	local e=$(sed -En 's/^libjq_la_LDFLAGS\s*=.*\s+-version-info\s+([0-9]+):([0-9]+):([0-9]+).*/\1-\3/p' \
			Makefile.am)
	if [ ! "${e}" ] || [ "${_SOVERSION}" != "$(( "${e}" ))" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}
