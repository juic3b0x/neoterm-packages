NEOTERM_PKG_HOMEPAGE=https://xorg.freedesktop.org/wiki/
NEOTERM_PKG_DESCRIPTION="Xorg server"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="21.1.10"
NEOTERM_PKG_SRCURL=https://xorg.freedesktop.org/releases/individual/xserver/xorg-server-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=ceb0b3a2efc57ac3ccf388d3dc88b97615068639fb284d469689ae3d105611d0
NEOTERM_PKG_DEPENDS="libandroid-shmem, libdrm, libpciaccess, libpixman, libx11, libxau, libxcvt, libxfont2, libxinerama, libxkbfile, libxshmfence, opengl, openssl, xkeyboard-config, xorg-protocol-txt, xorg-xkbcomp"

# Needed for Xephyr
NEOTERM_PKG_BUILD_DEPENDS="xcb-util, xcb-util-image, xcb-util-keysyms, xcb-util-renderutil, xcb-util-wm"

NEOTERM_PKG_RECOMMENDS="xf86-video-dummy, xf86-input-void"
NEOTERM_PKG_NO_STATICSPLIT=true

# Provided by xorg-protocol-txt (subpackage of xorg-server-xvfb):
NEOTERM_PKG_RM_AFTER_INSTALL="lib/xorg/protocol.txt"

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
--disable-tests
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
--enable-xorg
--disable-glamor
--disable-dmx
--disable-xvfb
--disable-xnest
--disable-xwayland
--disable-xwin
--enable-kdrive
--enable-xephyr
--disable-libunwind
--enable-xshmfence
--enable-ipv6
--with-sha1=libcrypto
--with-fontrootdir=${NEOTERM_PREFIX}/share/fonts
--with-xkb-path=${NEOTERM_PREFIX}/share/X11/xkb
LIBS=-landroid-shmem"

neoterm_step_pre_configure() {
	CFLAGS+=" -fcommon -fPIC -DFNDELAY=O_NDELAY -Wno-int-to-pointer-cast"
	CPPFLAGS+=" -fcommon -fPIC -I${NEOTERM_PREFIX}/include/libdrm"

	if [ "$NEOTERM_DEBUG_BUILD" = "true" ]; then
		NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" --enable-debug"
	fi

	# fixing automake version mismatch
	cd ${NEOTERM_PKG_SRCDIR}
	files=`find . -name configure -o -name config.status -o -name Makefile.in`
	for file in $files; do rm $file; done
	unset files

	#you will need xutils-dev package for xorg-macros installed
	autoreconf -if
	cd -
}

neoterm_step_post_make_install () {
	rm -f "${NEOTERM_PREFIX}/usr/share/X11/xkb/compiled"
	install -Dm644 -t "$NEOTERM_PREFIX/etc/X11/" "${NEOTERM_PKG_BUILDER_DIR}/xorg.conf" 
}

## The following is required for package 'tigervnc'.
if [ "${#}" -eq 1 ] && [ "${1}" == "xorg_server_flags" ]; then
	echo ${NEOTERM_PKG_EXTRA_CONFIGURE_ARGS}
	return
fi
