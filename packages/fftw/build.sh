NEOTERM_PKG_HOMEPAGE=http://www.fftw.org/
NEOTERM_PKG_DESCRIPTION="Library for computing the Discrete Fourier Transform (DFT) in one or more dimensions"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.3.10
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=http://www.fftw.org/fftw-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=56c932549852cddcfafdab3820b0200c7742675be92179e59e6215b340e26467
NEOTERM_PKG_BREAKS="fftw-dev"
NEOTERM_PKG_REPLACES="fftw-dev"
# ac_cv_func_clock_gettime=no avoids having clock_gettime(CLOCK_SGI_CYCLE, &t)
# being used. It's not supported on Android but fails at runtime and, fftw
# does not check the return value so gets bogus values.
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--enable-threads ac_cv_func_clock_gettime=no"
NEOTERM_PKG_RM_AFTER_INSTALL="include/fftw*.f*"

neoterm_step_post_make_install() {
	local COMMON_ARGS="$NEOTERM_PKG_EXTRA_CONFIGURE_ARGS"
	local feature
	for feature in float long-double; do
		make clean
		NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="$COMMON_ARGS --enable-$feature"
		rm -Rf $NEOTERM_PKG_TMPDIR/config-scripts
		neoterm_step_configure
		make -j $NEOTERM_MAKE_PROCESSES install
	done
}
