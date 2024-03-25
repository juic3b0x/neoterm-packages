NEOTERM_PKG_HOMEPAGE=https://github.com/strukturag/libheif
NEOTERM_PKG_DESCRIPTION="HEIF (HEIC/AVIF) image encoding and decoding library"
NEOTERM_PKG_LICENSE="LGPL-3.0, MIT"
NEOTERM_PKG_LICENSE_FILE="COPYING"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.17.6"
NEOTERM_PKG_SRCURL=https://github.com/strukturag/libheif/releases/download/v${NEOTERM_PKG_VERSION}/libheif-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=8390baf4913eda0a183e132cec62b875fb2ef507ced5ddddc98dfd2f17780aee
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="gdk-pixbuf, glib, libaom, libc++, libdav1d, libde265, librav1e, libx265"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DENABLE_PLUGIN_LOADING=OFF
"

neoterm_step_pre_configure() {
	# SOVERSION suffix is needed for SONAME of shared libs to avoid conflict
	# with system ones (in /system/lib64 or /system/lib):
	NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" -DCMAKE_SYSTEM_NAME=Linux"
}

neoterm_step_post_massage() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION_GUARD_FILES="lib/libheif.so.1"
	local f
	for f in ${_SOVERSION_GUARD_FILES}; do
		if [ ! -e "${f}" ]; then
			neoterm_error_exit "SOVERSION guard check failed."
		fi
	done

	# Check if SONAME is properly set:
	if ! readelf -d lib/libheif.so | grep -q '(SONAME).*\[libheif\.so\.'; then
		neoterm_error_exit "SONAME for libheif.so is not properly set."
	fi
}
