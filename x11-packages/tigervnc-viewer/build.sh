NEOTERM_PKG_HOMEPAGE=https://tigervnc.org/
NEOTERM_PKG_DESCRIPTION="A viewer (client) for Virtual Network Computing"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.13.1
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/TigerVNC/tigervnc/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=b7c5b8ed9e4e2c2f48c7b2c9f21927db345e542243b4be88e066b2daa3d1ae25
NEOTERM_PKG_DEPENDS="fltk, libandroid-shmem, libc++, libgmp, libgnutls, libjpeg-turbo, libnettle, libpixman, libx11, libxext, libxi, libxrandr, libxrender, zlib"
NEOTERM_PKG_CONFLICTS="tigervnc (<< 1.9.0-4)"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-DBUILD_SERVER=OFF
-DENABLE_NLS=OFF
-DFLTK_MATH_LIBRARY=
"

neoterm_step_pre_configure() {
	LDFLAGS+=" -landroid-shmem"
}
