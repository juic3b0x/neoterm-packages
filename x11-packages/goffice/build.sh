NEOTERM_PKG_HOMEPAGE=https://gitlab.gnome.org/GNOME/goffice/
NEOTERM_PKG_DESCRIPTION="A GLib/GTK+ set of document-centric objects and utilities"
NEOTERM_PKG_LICENSE="GPL-2.0, GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
_MAJOR_VERSION=0.10
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.55
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://download.gnome.org/sources/goffice/${_MAJOR_VERSION}/goffice-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=16a221191855a6a6c0d06b1ef8e481cf3f52041a654ec96d35817045ba1a99af
NEOTERM_PKG_DEPENDS="gdk-pixbuf, glib, gtk3, libcairo, libgsf, librsvg, libspectre, libxml2, libxslt, pango, zlib"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner"
NEOTERM_PKG_DISABLE_GIR=false
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-introspection=yes
--with-lasem=no
--without-long-double
"

neoterm_step_pre_configure() {
	neoterm_setup_gir

	CPPFLAGS+=" -D__USE_GNU"
}

neoterm_step_post_configure() {
	touch ./goffice/g-ir-scanner
}
