NEOTERM_PKG_HOMEPAGE=https://computing.llnl.gov/projects/sundials
NEOTERM_PKG_DESCRIPTION="SUite of Nonlinear and DIfferential/ALgebraic equation Solvers."
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm-user-repository"
NEOTERM_PKG_VERSION="7.0.0"
NEOTERM_PKG_SRCURL=https://github.com/LLNL/sundials/releases/download/v${NEOTERM_PKG_VERSION}/sundials-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=d762a7950ef4097fbe9d289f67a8fb717a0b9f90f87ed82170eb5c36c0a07989
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="suitesparse"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DCMAKE_SYSTEM_NAME=Linux
-DBUILD_ARKODE=ON
-DBUILD_CVODE=ON
-DBUILD_CVODES=ON
-DBUILD_IDA=ON
-DBUILD_IDAS=ON
-DBUILD_KINSOL=ON
-DBUILD_SHARED_LIBS=ON
-DBUILD_STATIC_LIBS=ON
-DBUILD_FORTRAN_MODULE_INTERFACE=OFF
-DENABLE_KLU=ON
-DKLU_INCLUDE_DIR=$NEOTERM_PREFIX/include/suitesparse
-DKLU_LIBRARY_DIR=$NEOTERM_PREFIX/lib
-DENABLE_OPENMP=ON
-DENABLE_PTHREAD=ON
-DEXAMPLES_INSTALL=OFF
"
NEOTERM_PKG_BLACKLISTED_ARCHES="arm, i686"
NEOTERM_PKG_RM_AFTER_INSTALL="examples/"

neoterm_step_post_massage() {
	# Do not forget to bump revision of reverse dependencies and rebuild them
	# after SOVERSION is changed.
	local _SOVERSION_GUARD_FILES="
lib/libsundials_arkode.so.6
lib/libsundials_core.so.7
lib/libsundials_cvode.so.7
lib/libsundials_cvodes.so.7
lib/libsundials_ida.so.7
lib/libsundials_idas.so.6
lib/libsundials_kinsol.so.7
lib/libsundials_nvecmanyvector.so.7
lib/libsundials_nvecopenmp.so.7
lib/libsundials_nvecpthreads.so.7
lib/libsundials_nvecserial.so.7
lib/libsundials_sunlinsolband.so.5
lib/libsundials_sunlinsoldense.so.5
lib/libsundials_sunlinsolklu.so.5
lib/libsundials_sunlinsolpcg.so.5
lib/libsundials_sunlinsolspbcgs.so.5
lib/libsundials_sunlinsolspfgmr.so.5
lib/libsundials_sunlinsolspgmr.so.5
lib/libsundials_sunlinsolsptfqmr.so.5
lib/libsundials_sunmatrixband.so.5
lib/libsundials_sunmatrixdense.so.5
lib/libsundials_sunmatrixsparse.so.5
lib/libsundials_sunnonlinsolfixedpoint.so.4
lib/libsundials_sunnonlinsolnewton.so.4
"
	local f
	for f in ${_SOVERSION_GUARD_FILES}; do
		if [ ! -e "${f}" ]; then
			neoterm_error_exit "SOVERSION guard check failed."
		fi
	done
}
