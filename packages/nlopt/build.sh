NEOTERM_PKG_HOMEPAGE=https://nlopt.readthedocs.io/
NEOTERM_PKG_DESCRIPTION="Library for nonlinear optimization"
NEOTERM_PKG_LICENSE="LGPL-2.1, MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.7.1
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/stevengj/nlopt/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=db88232fa5cef0ff6e39943fc63ab6074208831dc0031cf1545f6ecd31ae2a1a
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DNLOPT_CXX=ON
-DNLOPT_FORTRAN=OFF
-DNLOPT_PYTHON=OFF
-DNLOPT_OCTAVE=OFF
-DNLOPT_MATLAB=OFF
-DNLOPT_GUILE=OFF
-DNLOPT_SWIG=OFF
-DNLOPT_TESTS=OFF
"
NEOTERM_PKG_AUTO_UPDATE=true
