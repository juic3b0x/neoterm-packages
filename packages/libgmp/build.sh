NEOTERM_PKG_HOMEPAGE=https://gmplib.org/
NEOTERM_PKG_DESCRIPTION="Library for arbitrary precision arithmetic"
NEOTERM_PKG_LICENSE="LGPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=6.3.0
NEOTERM_PKG_SRCURL=https://mirrors.kernel.org/gnu/gmp/gmp-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=a3c2b80201b89e68616f4ad30bc66aee4927c3ce50e33929ca819d5c43538898
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_BREAKS="libgmp-dev"
NEOTERM_PKG_REPLACES="libgmp-dev"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--enable-cxx"

neoterm_step_pre_configure() {
	# the cxx tests fail because it won't link properly without this
	CXXFLAGS+=" -L$NEOTERM_PREFIX/lib"
}
