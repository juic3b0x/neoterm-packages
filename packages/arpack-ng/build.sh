NEOTERM_PKG_HOMEPAGE=https://github.com/opencollab/arpack-ng
NEOTERM_PKG_DESCRIPTION="Collection of Fortran77 subroutines designed to solve large scale eigenvalue problems."
NEOTERM_PKG_LICENSE="BSD"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.9.0
NEOTERM_PKG_SRCURL=https://github.com/opencollab/arpack-ng/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=24f2a2b259992d3c797d80f626878aa8e2ed5009d549dad57854bbcfb95e1ed0
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
lib/libarpack.so.2
"
	local f
	for f in ${_SOVERSION_GUARD_FILES}; do
		if [ ! -e "${f}" ]; then
			neoterm_error_exit "SOVERSION guard check failed."
		fi
	done
}
