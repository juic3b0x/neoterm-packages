NEOTERM_PKG_HOMEPAGE=https://www.fltk.org/
NEOTERM_PKG_DESCRIPTION="Graphical user interface toolkit for X"
NEOTERM_PKG_LICENSE="LGPL-2.0"
NEOTERM_PKG_LICENSE_FILE="COPYING"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.3.9"
NEOTERM_PKG_SRCURL=https://www.fltk.org/pub/fltk/${NEOTERM_PKG_VERSION}/fltk-${NEOTERM_PKG_VERSION}-source.tar.gz
NEOTERM_PKG_SHA256=d736b0445c50d607432c03d5ba5e82f3fba2660b10bc1618db8e077a42d9511b
NEOTERM_PKG_DEPENDS="fontconfig, glu, libc++, libjpeg-turbo, libpng, libx11, libxcursor, libxext, libxfixes, libxft, libxinerama, libxrender, opengl, zlib"
NEOTERM_PKG_BUILD_IN_SRC=true

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-shared
--enable-threads
--enable-xinerama
--enable-xft
--enable-xfixes
--enable-xcursor
--enable-xrender
"

neoterm_step_pre_configure() {
	sed -i 's/class Fl_XFont_On_Demand/class FL_EXPORT Fl_XFont_On_Demand/' FL/x.H
	sed -i 's/x-fluid.desktop/fluid.desktop/' -i fluid/Makefile
	sed -i -e 's/$(LINKFLTK)/$(LINKSHARED)/' -e 's/$(LINKFLTKIMG)/$(LINKSHARED)/' test/Makefile

	export LIBS="$LDFLAGS"
}
