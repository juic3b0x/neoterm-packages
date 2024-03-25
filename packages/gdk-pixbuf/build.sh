NEOTERM_PKG_HOMEPAGE=https://wiki.gnome.org/Projects/GdkPixbuf
NEOTERM_PKG_DESCRIPTION="Library for image loading and manipulation"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
_MAJOR_VERSION=2.42
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.10
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://ftp.gnome.org/pub/GNOME/sources/gdk-pixbuf/${_MAJOR_VERSION}/gdk-pixbuf-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=ee9b6c75d13ba096907a2e3c6b27b61bcd17f5c7ebeab5a5b439d2f2e39fe44b
NEOTERM_PKG_DEPENDS="glib, libpng, libtiff, libjpeg-turbo, zstd"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner"
NEOTERM_PKG_BREAKS="gdk-pixbuf-dev"
NEOTERM_PKG_REPLACES="gdk-pixbuf-dev"
NEOTERM_PKG_DISABLE_GIR=false
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dgtk_doc=false
-Dintrospection=enabled
-Dgio_sniffing=false
"

neoterm_step_pre_configure() {
	neoterm_setup_gir
}

neoterm_step_create_debscripts() {
	for i in postinst postrm triggers; do
		sed \
			"s|@NEOTERM_PREFIX@|${NEOTERM_PREFIX}|g" \
			"${NEOTERM_PKG_BUILDER_DIR}/hooks/${i}.in" > ./${i}
		chmod 755 ./${i}
	done
	unset i
	chmod 644 ./triggers
}
