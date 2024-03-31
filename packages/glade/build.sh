NEOTERM_PKG_HOMEPAGE=https://glade.gnome.org/
NEOTERM_PKG_DESCRIPTION="User interface designer for Gtk+ and GNOME"
NEOTERM_PKG_LICENSE="LGPL-2.0, GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
_MAJOR_VERSION=3.40
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.0
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://ftp.gnome.org/pub/GNOME/sources/glade/${_MAJOR_VERSION}/glade-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=31c9adaea849972ab9517b564e19ac19977ca97758b109edc3167008f53e3d9c
NEOTERM_PKG_DEPENDS="gdk-pixbuf, glib, gtk3, libcairo, libxml2, pango"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner, xsltproc"
NEOTERM_PKG_DISABLE_GIR=false
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dgjs=disabled
-Dpython=disabled
-Dwebkit2gtk=disabled
-Dintrospection=true
" 

neoterm_step_pre_configure() {
	neoterm_setup_gir
}
