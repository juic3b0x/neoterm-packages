NEOTERM_PKG_HOMEPAGE=https://github.com/google/zopfli
NEOTERM_PKG_DESCRIPTION="New zlib compatible compressor library"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.0.3
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://github.com/google/zopfli/archive/zopfli-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=e955a7739f71af37ef3349c4fa141c648e8775bceb2195be07e86f8e638814bd
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_BREAKS="libzopfli-dev"
NEOTERM_PKG_REPLACES="libzopfli-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="-DZOPFLI_BUILD_SHARED=ON"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=1

	local v=$(echo ${NEOTERM_PKG_VERSION#*:} | cut -d . -f 1)
	if [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}
