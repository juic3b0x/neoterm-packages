NEOTERM_PKG_HOMEPAGE=https://github.com/kokkos
NEOTERM_PKG_DESCRIPTION="Implements a programming model in C++ for writing performance portable applications"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_LICENSE_FILE="Copyright.txt"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="4.2.01"
NEOTERM_PKG_SRCURL=https://github.com/kokkos/kokkos/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=cbabbabba021d00923fb357d2e1b905dda3838bd03c885a6752062fe03c67964
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libandroid-execinfo, libc++"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_SHARED_LIBS=ON
-DKokkos_ENABLE_LIBDL=OFF
"
NEOTERM_PKG_BLACKLISTED_ARCHES="arm, i686"

neoterm_step_pre_configure() {
	LDFLAGS+=" -landroid-execinfo"
}
