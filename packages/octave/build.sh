NEOTERM_PKG_HOMEPAGE=https://octave.org
NEOTERM_PKG_DESCRIPTION="GNU Octave is a high-level language, primarily intended for numerical computations. (only CLI)"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=8.4.0
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://ftpmirror.gnu.org/octave/octave-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=6f9ad73a3ee4291b6341d6c0f5e5c85d6e0310376e4991b959a6d340b3ffa8a8
NEOTERM_PKG_DEPENDS="arpack-ng, bzip2, fftw, fontconfig, freetype, glpk, graphicsmagick, libcurl, libhdf5, libiconv, libopenblas, libsndfile, openssl, pcre, portaudio, qhull, qrupdate-ng, rapidjson, readline, suitesparse, sundials, zlib"
NEOTERM_PKG_BUILD_DEPENDS="gnuplot, less"
NEOTERM_PKG_RECOMMENDS="gnuplot, less"
NEOTERM_PKG_CONFLICTS="octave-x"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--without-x
--disable-java
--enable-link-all-dependencies
--disable-openmp
--with-blas=openblas
--with-openssl=yes
--with-libiconv-prefix=$NEOTERM_PREFIX
--enable-fortran-calling-convention=f2c
ac_cv_header_glob_h=no
ac_cv_func_endpwent=no
ac_cv_func_getegid=no
ac_cv_func_geteuid=no
ac_cv_func_getgrent=no
ac_cv_func_getgrgid=no
ac_cv_func_getgrnam=no
ac_cv_func_getpwent=no
ac_cv_func_getpwnam=no
ac_cv_func_getpwnam_r=no
ac_cv_func_getpwuid=no
ac_cv_func_setgrent=no
ac_cv_func_setpwent=no
ac_cv_func_setpwuid=no
"
NEOTERM_PKG_BLACKLISTED_ARCHES="arm, i686"

neoterm_step_post_get_source() {
	# Version guard
	local ver_e=${NEOTERM_PKG_VERSION#*:}
	local ver_x=$(. $NEOTERM_SCRIPTDIR/x11-packages/octave-x/build.sh; echo ${NEOTERM_PKG_VERSION#*:})
	if [ "${ver_e}" != "${ver_x}" ]; then
		neoterm_error_exit "Version mismatch between octave and octave-x."
	fi
}

neoterm_step_pre_configure() {
	neoterm_setup_flang

	local flang_toolchain_dir="$(dirname $(dirname $(command -v flang-new)))"
	local flang_libs_dir="$flang_toolchain_dir/sysroot/usr/lib/$NEOTERM_HOST_PLATFORM"

	export F77="$FC"
	export ac_cv_f77_libs=" $flang_libs_dir/libFortranRuntime.a $flang_libs_dir/libFortranDecimal.a"

	LDFLAGS+=" -Wl,-rpath,$NEOTERM_PREFIX/lib/octave/$NEOTERM_PKG_VERSION"
	LDFLAGS+=" $($CC -print-libgcc-file-name)"
}
