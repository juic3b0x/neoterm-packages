NEOTERM_PKG_HOMEPAGE=https://github.com/fribidi/fribidi/
NEOTERM_PKG_DESCRIPTION="Implementation of the Unicode Bidirectional Algorithm"
NEOTERM_PKG_LICENSE="LGPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.0.13"
NEOTERM_PKG_SRCURL=https://github.com/fribidi/fribidi/releases/download/v$NEOTERM_PKG_VERSION/fribidi-$NEOTERM_PKG_VERSION.tar.xz
NEOTERM_PKG_SHA256=7fa16c80c81bd622f7b198d31356da139cc318a63fc7761217af4130903f54a2
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="glib"
NEOTERM_PKG_BREAKS="fribidi-dev"
NEOTERM_PKG_REPLACES="fribidi-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--disable-docs"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=0

	local a
	for a in INTERFACE_VERSION BINARY_AGE; do
		local _${a}=$(sed -En 's/^m4_define\(fribidi_'"${a,,}"',\s*([0-9]+).*/\1/p' \
				configure.ac)
	done
	local v=$(( _INTERFACE_VERSION - _BINARY_AGE ))
	if [ ! "${_INTERFACE_VERSION}" ] || [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}
