NEOTERM_PKG_HOMEPAGE=https://github.com/google/gumbo-parser
NEOTERM_PKG_DESCRIPTION="An HTML5 parsing library"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.10.1
NEOTERM_PKG_SRCURL=https://github.com/google/gumbo-parser/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=28463053d44a5dfbc4b77bcf49c8cee119338ffa636cc17fc3378421d714efad
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=1

	local e=$(sed -En 's/^libgumbo_la_LDFLAGS\s*=.*\s+-version-info\s+([0-9]+):([0-9]+):([0-9]+).*/\1-\3/p' \
			Makefile.am)
	if [ ! "${e}" ] || [ "${_SOVERSION}" != "$(( "${e}" ))" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}

neoterm_step_pre_configure() {
	./autogen.sh
}
