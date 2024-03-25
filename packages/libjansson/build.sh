NEOTERM_PKG_HOMEPAGE=http://www.digip.org/jansson/
NEOTERM_PKG_DESCRIPTION="C library for encoding, decoding and manipulating JSON data"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.14
NEOTERM_PKG_SRCURL=https://github.com/akheron/jansson/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=c739578bf6b764aa0752db9a2fdadcfe921c78f1228c7ec0bb47fa804c55d17b
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BREAKS="libjansson-dev"
NEOTERM_PKG_REPLACES="libjansson-dev"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=4

	local e=$(sed -n '/^libjansson_la_LDFLAGS/,/^[^\t]/p' src/Makefile.am | \
			 sed -En 's/\s*-version-info\s+([0-9]+):([0-9]+):([0-9]+).*/\1-\3/p')
	if [ ! "${e}" ] || [ "${_SOVERSION}" != "$(( "${e}" ))" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}

neoterm_step_pre_configure() {
	autoreconf -fi
}
