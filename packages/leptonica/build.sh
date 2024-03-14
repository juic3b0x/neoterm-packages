NEOTERM_PKG_HOMEPAGE=http://www.leptonica.com/
NEOTERM_PKG_DESCRIPTION="Library for image processing and image analysis"
NEOTERM_PKG_LICENSE="BSD 2-Clause"
NEOTERM_PKG_LICENSE_FILE="leptonica-license.txt"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.84.1"
NEOTERM_PKG_SRCURL=https://github.com/DanBloomberg/leptonica/archive/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=ecd7a868403b3963c4e33623595d77f2c87667e2cfdd9b370f87729192061bef
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="giflib, libjpeg-turbo, libpng, libtiff, libwebp, openjpeg, zlib"
NEOTERM_PKG_BREAKS="leptonica-dev"
NEOTERM_PKG_REPLACES="leptonica-dev"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=6

	local v=$(sed -En 's/^.*set_target_properties\s*\(leptonica PROPERTIES SOVERSION ([0-9]+).*$/\1/p' \
			src/CMakeLists.txt)
	if [ "${_SOVERSION}" != "${v}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}

neoterm_step_pre_configure() {
	# Silence tmpfile warnings:
	find src -name '*.c' | xargs -n 1 \
		sed -i 's/L_INFO("work-around: writing to a temp file\\n", __func__)/((void)0)/'

	./autogen.sh
}
