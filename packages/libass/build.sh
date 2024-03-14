NEOTERM_PKG_HOMEPAGE=https://github.com/libass/libass
NEOTERM_PKG_DESCRIPTION="A portable library for SSA/ASS subtitles rendering"
NEOTERM_PKG_LICENSE="BSD"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.17.1"
NEOTERM_PKG_SRCURL=https://github.com/libass/libass/releases/download/$NEOTERM_PKG_VERSION/libass-$NEOTERM_PKG_VERSION.tar.xz
NEOTERM_PKG_SHA256=f0da0bbfba476c16ae3e1cfd862256d30915911f7abaa1b16ce62ee653192784
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="fontconfig, fribidi, glib, harfbuzz"
NEOTERM_PKG_BREAKS="libass-dev"
NEOTERM_PKG_REPLACES="libass-dev"
# Avoid text relocations.
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" ac_cv_prog_nasm_check=no"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=9

	local a
	for a in LT_CURRENT LT_AGE; do
		local _${a}=$(sed -En 's/^LIBASS_'"${a}"'\s+=\s+([0-9]+).*/\1/p' \
				libass/Makefile_library.am)
	done
	local v=$(( _LT_CURRENT - _LT_AGE ))
	if [ ! "${_LT_CURRENT}" ] || [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}
