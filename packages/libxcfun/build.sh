NEOTERM_PKG_HOMEPAGE="https://github.com/dftlibs/xcfun"
NEOTERM_PKG_DESCRIPTION="A library of exchange-correlation functionals with arbitrary-order derivatives"
NEOTERM_PKG_GROUPS="science"
NEOTERM_PKG_LICENSE="MPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.1.1"
NEOTERM_PKG_SRCURL="https://github.com/dftlibs/xcfun/archive/refs/tags/v$NEOTERM_PKG_VERSION.tar.gz"
NEOTERM_PKG_SHA256=8b602df74c7be83d501532565deafd1b7881946d94789122f24c309a669298ab
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_SHARED_LIBS=ON
-DXCFUN_PYTHON_INTERFACE=OFF
-DENABLE_TESTALL=OFF
"
