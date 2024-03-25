NEOTERM_PKG_HOMEPAGE=https://libjpeg-turbo.virtualgl.org
NEOTERM_PKG_DESCRIPTION="Library for reading and writing JPEG image files"
NEOTERM_PKG_LICENSE="IJG, BSD 3-Clause, ZLIB"
NEOTERM_PKG_LICENSE_FILE="README.ijg, LICENSE.md"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="3.0.2"
NEOTERM_PKG_SRCURL=https://github.com/libjpeg-turbo/libjpeg-turbo/releases/download/${NEOTERM_PKG_VERSION}/libjpeg-turbo-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=c2ce515a78d91b09023773ef2770d6b0df77d674e144de80d63e0389b3a15ca6
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BREAKS="libjpeg-turbo-dev"
NEOTERM_PKG_REPLACES="libjpeg-turbo-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="-DWITH_JPEG8=1"

neoterm_step_pre_configure() {
	# SOVERSION suffix is needed for SONAME of shared libs to avoid conflict
	# with system ones (in /system/lib64 or /system/lib):
	NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" -DCMAKE_SYSTEM_NAME=Linux"
}

neoterm_step_post_massage() {
	# Check if SONAME is properly set:
	if ! readelf -d lib/libjpeg.so | grep -q '(SONAME).*\[libjpeg\.so\.'; then
		neoterm_error_exit "SONAME for libjpeg.so is not properly set."
	fi

	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION_GUARD_FILES="
lib/libjpeg.so.8
lib/libturbojpeg.so.0
"
	local f
	for f in ${_SOVERSION_GUARD_FILES}; do
		if [ ! -e "${f}" ]; then
			neoterm_error_exit "SOVERSION guard check failed."
		fi
	done
}
