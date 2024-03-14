NEOTERM_PKG_HOMEPAGE=https://jpegxl.info/
NEOTERM_PKG_DESCRIPTION="JPEG XL image format reference implementation"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.10.2"
NEOTERM_PKG_SRCURL=https://github.com/libjxl/libjxl/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=95e807f63143856dc4d161c071cca01115d2c6405b3d3209854ac6989dc6bb91
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="brotli, libc++"
NEOTERM_PKG_NO_STATICSPLIT=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DJPEGXL_ENABLE_JNI=False
-DJPEGXL_FORCE_SYSTEM_BROTLI=True
"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after RELEASE / SOVERSION is changed.
	local _SOVERSION=0.10

	for a in MAJOR SO_MINOR; do
		local _${a}=$(sed -En 's/^set\(JPEGXL_'"${a}"'_VERSION\s+([0-9]+).*/\1/p' \
				lib/CMakeLists.txt)
	done
	local v="${_MAJOR}"
	if [ "${_SO_MINOR}" != "0" ]; then
		v+=".${_SO_MINOR}"
	fi
	if [ "${_SOVERSION}" != "${v}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi

	./deps.sh
}
