NEOTERM_PKG_HOMEPAGE=https://github.com/LibVNC/x11vnc
NEOTERM_PKG_DESCRIPTION="VNC server for real X displays"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.9.16
NEOTERM_PKG_REVISION=11
NEOTERM_PKG_SRCURL=https://github.com/LibVNC/x11vnc/archive/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=885e5b5f5f25eec6f9e4a1e8be3d0ac71a686331ee1cfb442dba391111bd32bd
NEOTERM_PKG_DEPENDS="libandroid-shmem, libcairo, libvncserver, libx11, libxcomposite, libxcursor, libxdamage, libxext, libxfixes, libxi, libxinerama, libxrandr, libxtst, openssl, xorg-xdpyinfo"

# https://github.com/juic3b0x/neoterm-packages/issues/15240
NEOTERM_PKG_RM_AFTER_INSTALL="bin/Xdummy"

neoterm_step_pre_configure() {
	autoreconf -vi
	CFLAGS+=" -fcommon"
	export LIBS="-landroid-shmem"
}
