NEOTERM_PKG_HOMEPAGE=https://www.gnu.org/software/gsl/
NEOTERM_PKG_DESCRIPTION="GNU Scientific Library (GSL) providing a wide range of mathematical routines"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.7.1
NEOTERM_PKG_SRCURL=https://mirrors.kernel.org/gnu/gsl/gsl-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=dcb0fbd43048832b757ff9942691a8dd70026d5da0ff85601e52687f6deeb34b
NEOTERM_PKG_BREAKS="gsl-dev"
NEOTERM_PKG_REPLACES="gsl-dev"
# Do not remove `bin/gsl-config`
#NEOTERM_PKG_RM_AFTER_INSTALL="bin/ share/man/man1"

# Workaround for linker on Android 5 (fixed in Android 6) not supporting RTLD_GLOBAL.
# See https://github.com/juic3b0x/neoterm-packages/issues/507
export GSL_LDFLAGS="-Lcblas/.libs/ -lgslcblas"
