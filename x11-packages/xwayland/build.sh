NEOTERM_PKG_HOMEPAGE=https://xorg.freedesktop.org/wiki/
NEOTERM_PKG_DESCRIPTION="Wayland X11 server"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="23.2.4"
NEOTERM_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/xserver/xwayland-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=a99e159b6d0d33098b3b6ab22a88bfcece23c8b9d0ca72c535c55dcb0681b46b
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libandroid-shmem, libdrm, libepoxy, libpciaccess, libpixman, libwayland, libwayland-protocols, libx11, libxau, libxcvt, libxfont2, libxinerama, libxkbfile, libxshmfence, opengl, openssl, xkeyboard-config, xorg-protocol-txt, xorg-xkbcomp"
NEOTERM_PKG_BUILD_DEPENDS="libwayland-cross-scanner"

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dmitshm=true
-Dxres=true
-Dxv=true
-Dsecure-rpc=false
-Dscreensaver=true
-Dxdmcp=true
-Dglx=true
-Ddri3=true
-Dxinerama=true
-Dxace=true
-Dxcsecurity=true
-Dxf86bigfont=true
-Ddrm=true
-Dglamor=false
-Dxwayland_eglstream=false
-Dxvfb=false
-Dlibunwind=false
-Dipv6=true
-Dsha1=libcrypto
-Ddefault_font_path=$NEOTERM_PREFIX/share/fonts
"

# Remove files conflicting with xorg-server:
NEOTERM_PKG_RM_AFTER_INSTALL="
lib/xorg/protocol.txt
share/X11/xkb/compiled
share/man/man1/Xserver.1
"

neoterm_step_pre_configure() {
	export PATH="$NEOTERM_PREFIX/opt/libwayland/cross/bin:$PATH"

	CFLAGS+=" -fcommon -fPIC -DFNDELAY=O_NDELAY -Wno-int-to-pointer-cast"
	CPPFLAGS+=" -fcommon -fPIC -I${NEOTERM_PREFIX}/include/libdrm"
	LDFLAGS+=" -landroid-shmem"
}
