NEOTERM_PKG_HOMEPAGE=https://github.com/gflags/gflags
NEOTERM_PKG_DESCRIPTION="A C++ library that implements commandline flags processing"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_LICENSE_FILE="COPYING.txt"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.2.2
NEOTERM_PKG_REVISION=9
NEOTERM_PKG_SRCURL=https://github.com/gflags/gflags/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=34af2f15cf7367513b352bdcd2493ab14ce43692d2dcd9dfc499492966c64dcf
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_BREAKS="gflags-dev"
NEOTERM_PKG_REPLACES="gflags-dev"
NEOTERM_PKG_FORCE_CMAKE=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_SHARED_LIBS=ON
-DBUILD_STATIC_LIBS=ON
-DBUILD_gflags_LIBS=ON
-DINSTALL_HEADERS=ON
"

neoterm_step_post_get_source() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION=2.2

	local _MAJOR=$(echo ${NEOTERM_PKG_VERSION#*:} | cut -d . -f 1)
	local _MINOR=$(echo ${NEOTERM_PKG_VERSION#*:} | cut -d . -f 2)
	local v=${_MAJOR}
	if [ "${_MAJOR}" == 2 ]; then
		v+=".${_MINOR}"
	fi
	if [ "${v}" != "${_SOVERSION}" ]; then
		neoterm_error_exit "SOVERSION guard check failed."
	fi
}

neoterm_step_post_make_install() {
	#Any old packages using the library name of libgflags
	ln -sfr "$NEOTERM_PREFIX"/lib/pkgconfig/gflags.pc \
		"$NEOTERM_PREFIX"/lib/pkgconfig/libgflags.pc
}
