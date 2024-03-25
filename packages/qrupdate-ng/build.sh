NEOTERM_PKG_HOMEPAGE=https://github.com/mpimd-csc/qrupdate-ng
NEOTERM_PKG_DESCRIPTION="A Library for Fast Updating of QR and Cholesky Decompositions."
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.1.5
NEOTERM_PKG_SRCURL=https://github.com/mpimd-csc/qrupdate-ng/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=912426f7cb9436bb3490c3102a64d9a2c3883d700268a26d4d738b7607903757
NEOTERM_PKG_DEPENDS="libopenblas"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
"
NEOTERM_PKG_BLACKLISTED_ARCHES="arm, i686"

neoterm_step_pre_configure() {
	neoterm_setup_flang
}

neoterm_step_post_massage() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION_GUARD_FILES="
lib/libqrupdate.so.1
"
	local f
	for f in ${_SOVERSION_GUARD_FILES}; do
		if [ ! -e "${f}" ]; then
			neoterm_error_exit "SOVERSION guard check failed."
		fi
	done
}
