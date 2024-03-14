# x11-packages
NEOTERM_PKG_HOMEPAGE=https://sourceforge.net/projects/pypanel/
NEOTERM_PKG_DESCRIPTION="A lightweight panel/taskbar for X11 window managers written in python."
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.4
NEOTERM_PKG_REVISION=35
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/pypanel/PyPanel-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=4e612b43c61b3a8af7d57a0364f6cd89df481dc41e20728afa643e9e3546e911
NEOTERM_PKG_DEPENDS="freetype, imlib2, libx11, libxft, python2, python2-xlib"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_CONFFILES="etc/pypanelrc"

neoterm_step_make() {
	"${CC}" -DNDEBUG \
			-fwrapv \
			-Wall \
			-Wstrict-prototypes \
			-fno-strict-aliasing \
			-Oz \
			-fPIC \
			-DHAVE_XFT=1 \
			-DIMLIB2_FIX=1 \
			-I$NEOTERM_PREFIX/include \
			-I$NEOTERM_PREFIX/include/freetype2 \
			-I$NEOTERM_PREFIX/include/libpng16 \
			-c ppmodule.c \
			-o ppmodule.o \

	"${CC}" -shared \
			ppmodule.o \
			$LDFLAGS \
			-lfreetype \
			-lXft \
			-lImlib2 \
			-lpython2.7 \
			-lX11 \
			-o ppmodule.so
}

neoterm_step_make_install() {
	mkdir -p "${NEOTERM_PREFIX}/bin"
	cp -f pypanel "${NEOTERM_PREFIX}/bin/pypanel"
	chmod 755 "${NEOTERM_PREFIX}/bin/pypanel"

	mkdir -p "${NEOTERM_PREFIX}/etc"
	cp -f pypanelrc "${NEOTERM_PREFIX}/etc/pypanelrc"
	chmod 644 "${NEOTERM_PREFIX}/etc/pypanelrc"

	mkdir -p "${NEOTERM_PREFIX}/lib/python2.7/site-packages"
	cp ppmodule.so "${NEOTERM_PREFIX}/lib/python2.7/site-packages/ppmodule.so"
	chmod 644 "${NEOTERM_PREFIX}/lib/python2.7/site-packages/ppmodule.so"

	mkdir -p "${NEOTERM_PREFIX}/lib/python2.7/site-packages/pypanel"
	cp -f COPYING README pypanelrc ppicon.png "${NEOTERM_PREFIX}/lib/python2.7/site-packages/pypanel/"
	chmod 644 ${NEOTERM_PREFIX}/lib/python2.7/site-packages/pypanel/*
}
