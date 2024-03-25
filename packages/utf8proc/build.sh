NEOTERM_PKG_HOMEPAGE=https://github.com/JuliaLang/utf8proc
NEOTERM_PKG_DESCRIPTION="Library for processing UTF-8 Unicode data"
NEOTERM_PKG_LICENSE="BSD"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.9.0"
NEOTERM_PKG_SRCURL=https://github.com/JuliaLang/utf8proc/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=18c1626e9fc5a2e192311e36b3010bfc698078f692888940f1fa150547abb0c1
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BREAKS="utf8proc-dev"
NEOTERM_PKG_REPLACES="utf8proc-dev"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=3

	local v=$(sed -En 's/^MAJOR=([0-9]+).*/\1/p' Makefile)
	if [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}

neoterm_step_pre_configure() {
	rm $NEOTERM_PKG_SRCDIR/CMakeLists.txt
}
