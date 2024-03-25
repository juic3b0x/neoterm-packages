NEOTERM_PKG_HOMEPAGE=http://www.openjpeg.org/
NEOTERM_PKG_DESCRIPTION="JPEG 2000 image compression library"
NEOTERM_PKG_LICENSE="BSD 2-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.5.2"
NEOTERM_PKG_SRCURL=https://github.com/uclouvain/openjpeg/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=90e3896fed910c376aaf79cdd98bdfdaf98c6472efd8e1debf0a854938cbda6a
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BREAKS="openjpeg-dev"
NEOTERM_PKG_REPLACES="openjpeg-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="-DBUILD_STATIC_LIBS=OFF"
# for fast building packages that depend on openjpeg with cmake

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _MAJOR_VERSION=2
	local _SOVERSION=7

	case "$NEOTERM_PKG_VERSION" in
		${_MAJOR_VERSION}.*|*:${_MAJOR_VERSION}.* ) ;;
		* ) neoterm_error_exit "Version guard check failed." ;;
	esac

	local v=$(sed -En 's/^.*set\(OPENJPEG_SOVERSION ([0-9]+).*$/\1/p' \
			CMakeLists.txt)
	if [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}

neoterm_step_pre_configure() {
	# Certain packages are not safe to build on device because their
	# build.sh script deletes specific files in $NEOTERM_PREFIX.
	if $NEOTERM_ON_DEVICE_BUILD; then
		neoterm_error_exit "Package '$NEOTERM_PKG_NAME' is not safe for on-device builds."
	fi

	# Force symlinks to be overwritten:
	rm -Rf $NEOTERM_PREFIX/lib/libopenjp2.so*
}
