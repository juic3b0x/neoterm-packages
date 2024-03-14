NEOTERM_PKG_HOMEPAGE=http://www.mega-nerd.com/libsndfile
NEOTERM_PKG_DESCRIPTION="Library for reading/writing audio files"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.2.2"
NEOTERM_PKG_SRCURL=https://github.com/libsndfile/libsndfile/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=ffe12ef8add3eaca876f04087734e6e8e029350082f3251f565fa9da55b52121
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libflac, libogg, libopus, libvorbis"
NEOTERM_PKG_BREAKS="libsndfile-dev"
NEOTERM_PKG_REPLACES="libsndfile-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-sqlite
--disable-alsa
--disable-mpeg
"
NEOTERM_PKG_RM_AFTER_INSTALL="bin/ share/man/man1/"

neoterm_step_post_get_source() {
	rm -f CMakeLists.txt

	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=1

	local a
	for a in LT_CURRENT LT_AGE; do
		local _${a}=$(sed -En 's/^m4_define\(\['"${a,,}"'\],\s*\[([0-9]+)\].*/\1/p' \
				configure.ac)
	done
	local v=$(( _LT_CURRENT - _LT_AGE ))
	if [ ! "${_LT_CURRENT}" ] || [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}

neoterm_step_pre_configure() {
	autoreconf -fi
}
