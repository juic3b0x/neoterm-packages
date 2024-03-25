NEOTERM_PKG_HOMEPAGE=https://github.com/strukturag/libde265
NEOTERM_PKG_DESCRIPTION="H.265/HEVC video stream decoder library"
NEOTERM_PKG_LICENSE="LGPL-3.0, MIT"
NEOTERM_PKG_LICENSE_FILE="COPYING"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.0.15"
NEOTERM_PKG_SRCURL=https://github.com/strukturag/libde265/releases/download/v$NEOTERM_PKG_VERSION/libde265-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=00251986c29d34d3af7117ed05874950c875dd9292d016be29d3b3762666511d
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--disable-sherlock265 --disable-arm --disable-encoder"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=0

	local a
	for a in CURRENT AGE; do
		local _LT_${a}=$(sed -En 's/^LIBDE265_'"${a}"'=([0-9]+).*/\1/p' \
				configure.ac)
	done
	local v=$(( _LT_CURRENT - _LT_AGE ))
	if [ ! "${_LT_CURRENT}" ] || [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}

neoterm_step_pre_configure() {
	sed -i "s#tools##;s#acceleration-speed##" ${NEOTERM_PKG_SRCDIR}/Makefile.am
	autoreconf -fi

	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
