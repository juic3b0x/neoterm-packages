NEOTERM_PKG_HOMEPAGE=https://xorg.freedesktop.org/
NEOTERM_PKG_DESCRIPTION="X virtual framebuffer"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=21.1.8
NEOTERM_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/xserver/xorg-server-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=38aadb735650c8024ee25211c190bf8aad844c5f59632761ab1ef4c4d5aeb152

NEOTERM_PKG_DEPENDS="libandroid-shmem, libdrm, libpixman, libx11, libxau, libxfont2, libxinerama, libxkbfile, libxshmfence, opengl, openssl, xkeyboard-config, xorg-protocol-txt, xorg-xkbcomp"
NEOTERM_PKG_BUILD_DEPENDS="libxcvt, mesa-dev"
NEOTERM_PKG_CONFLICTS="xorg-xvfb"
NEOTERM_PKG_REPLACES="xorg-xvfb"

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_path_RAWCPP=/usr/bin/cpp
--enable-composite
--enable-mitshm
--enable-xres
--enable-record
--enable-xv
--enable-xvmc
--enable-dga
--enable-screensaver
--enable-xdmcp
--enable-glx
--disable-dri
--disable-dri2
--enable-dri3
--enable-present
--enable-xinerama
--enable-xf86vidmode
--enable-xace
--enable-xcsecurity
--enable-dbe
--enable-xf86bigfont
--disable-xfree86-utils
--disable-vgahw
--disable-vbe
--disable-int10-module
--enable-libdrm
--disable-pciaccess
--disable-linux-acpi
--disable-linux-apm
--disable-xorg
--disable-dmx
--enable-xvfb
--disable-xnest
--disable-xwayland
--disable-xwin
--disable-kdrive
--disable-xephyr
--disable-libunwind
--enable-xshmfence
--enable-ipv6
--with-sha1=libcrypto
--with-fontrootdir=${NEOTERM_PREFIX}/share/fonts
--with-xkb-path=${NEOTERM_PREFIX}/share/X11/xkb
LIBS=-landroid-shmem
"

NEOTERM_PKG_RM_AFTER_INSTALL="
share/X11/xkb/compiled
share/man/man1/Xserver.1
"

neoterm_step_pre_configure() {
	CFLAGS+=" -DFNDELAY=O_NDELAY"
	CPPFLAGS+=" -I${NEOTERM_PREFIX}/include/libdrm"

	if [ "$NEOTERM_DEBUG_BUILD" = "true" ]; then
		NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" --enable-debug"
	fi
}
