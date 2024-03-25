NEOTERM_PKG_HOMEPAGE=https://libimobiledevice.org
NEOTERM_PKG_DESCRIPTION="A small portable C library to handle Apple Property List files in binary or XML format"
NEOTERM_PKG_LICENSE="GPL-2.0, LGPL-2.1"
NEOTERM_PKG_LICENSE_FILE="COPYING, COPYING.LESSER"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.4.0"
NEOTERM_PKG_SRCURL=https://github.com/libimobiledevice/libplist/releases/download/${NEOTERM_PKG_VERSION}/libplist-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=3f5868ae15b117320c1ff5e71be53d29469d4696c4085f89db1975705781a7cd
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--without-cython
"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=4

	local e=$(sed -En 's/^LIBPLIST_SO_VERSION="?([0-9]+):([0-9]+):([0-9]+).*/\1-\3/p' \
				configure.ac)
	if [ ! "${e}" ] || [ "${_SOVERSION}" != "$(( "${e}" ))" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}

neoterm_step_pre_configure() {
	autoreconf -fi
}
