NEOTERM_PKG_HOMEPAGE=https://libical.github.io/libical/
NEOTERM_PKG_DESCRIPTION="Libical is an Open Source implementation of the iCalendar protocols and protocol data units"
NEOTERM_PKG_LICENSE="LGPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="3.0.17"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/libical/libical/releases/download/v$NEOTERM_PKG_VERSION/libical-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=bcda9a6db6870240328752854d1ea475af9bbc6356e6771018200e475e5f781b
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libc++, libicu"
NEOTERM_PKG_BREAKS="libical-dev"
NEOTERM_PKG_REPLACES="libical-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS=" -DSHARED_ONLY=true -DICAL_GLIB=false -DUSE_BUILTIN_TZDATA=true -DPERL_EXECUTABLE=/usr/bin/perl"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=3

	local v=$(sed -En 's/^set\(LIBICAL_LIB_MAJOR_VERSION\s+"?([0-9]+).*/\1/p' \
			CMakeLists.txt)
	if [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}
