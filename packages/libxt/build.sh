# X11 package
NEOTERM_PKG_HOMEPAGE=https://xorg.freedesktop.org/
NEOTERM_PKG_DESCRIPTION="X11 toolkit intrinsics library"
# Licenses: MIT, HPND
NEOTERM_PKG_LICENSE="custom"
NEOTERM_PKG_LICENSE_FILE="COPYING"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.3.0
NEOTERM_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/lib/libXt-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=52820b3cdb827d08dc90bdfd1b0022a3ad8919b57a39808b12591973b331bf91
NEOTERM_PKG_DEPENDS="libice, libsm, libx11"
NEOTERM_PKG_BUILD_DEPENDS="xorg-util-macros"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_path_RAWCPP=/usr/bin/cpp
--enable-malloc0returnsnull
"

neoterm_step_pre_configure() {
	export CFLAGS_FOR_BUILD=" "
	export LDFLAGS_FOR_BUILD=" "
}
