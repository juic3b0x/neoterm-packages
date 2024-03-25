NEOTERM_PKG_HOMEPAGE=https://sourceforge.net/projects/florence/
NEOTERM_PKG_DESCRIPTION="A configurable on-screen virtual keyboard"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.6.3
NEOTERM_PKG_REVISION=33
NEOTERM_PKG_SRCURL=https://sourceforge.net/projects/florence/files/florence/${NEOTERM_PKG_VERSION}/florence-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=422992fd07d285be73cce721a203e22cee21320d69b0fda1579ce62944c5091e
NEOTERM_PKG_DEPENDS="gdk-pixbuf, glib, gstreamer, gtk3, libcairo, librsvg, libx11, libxext, libxml2, libxtst, pango"
NEOTERM_MAKE_PROCESSES=1

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-static
--without-notification
--without-at-spi
--with-panelapplet
--with-xtst
--without-docs
"

NEOTERM_PKG_RM_AFTER_INSTALL="
lib/locale
"

neoterm_step_pre_configure() {
	export LIBS="-lglib-2.0 -lgio-2.0"
}
