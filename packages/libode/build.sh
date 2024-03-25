NEOTERM_PKG_HOMEPAGE="https://www.ode.org"
NEOTERM_PKG_DESCRIPTION="An open source, high performance library for simulating rigid body dynamics"
NEOTERM_PKG_GROUPS="science"
NEOTERM_PKG_LICENSE="BSD 3-Clause, LGPL-2.1"
NEOTERM_PKG_MAINTAINER="Pooya Moradi <pvonmoradi@gmail.com>"
NEOTERM_PKG_VERSION="0.16.4"
NEOTERM_PKG_SRCURL="https://bitbucket.org/odedevs/ode/downloads/ode-$NEOTERM_PKG_VERSION.tar.gz"
NEOTERM_PKG_SHA256=71037b8281c6c86b0a55729f90d5db697abe4cbec1d8118157e00d48ec253467
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_FORCE_CMAKE=true
NEOTERM_PKG_DEPENDS="libc++, libccd"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS='
-DBUILD_SHARED_LIBS=ON
-DODE_WITH_DEMOS=OFF
-DODE_WITH_TESTS=OFF
-DODE_WITH_LIBCCD=ON
-DODE_WITH_LIBCCD_SYSTEM=ON
'

neoterm_step_pre_configure() {
	# Use double-precision for 64-bit archs, otherwise use single-precision
	case "$NEOTERM_ARCH" in
		"aarch64" |  "x86_64")
			NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=' -DODE_DOUBLE_PRECISION=ON'
			;;
		"arm" | "i686")
			NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=' -DODE_DOUBLE_PRECISION=OFF'
			;;
		*)
			NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=' -DODE_DOUBLE_PRECISION=OFF'
			;;
	esac
}
