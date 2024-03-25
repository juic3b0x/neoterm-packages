NEOTERM_PKG_HOMEPAGE=https://wiki.gnome.org/Apps/Evince
NEOTERM_PKG_DESCRIPTION="document viewer for multiple document formats"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="45.0"
NEOTERM_PKG_SRCURL=https://download.gnome.org/sources/evince/${NEOTERM_PKG_VERSION%.*}/evince-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=d18647d4275cbddf0d32817b1d04e307342a85be914ec4dad2d8082aaf8aa4a8
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="atk, djvulibre, gdk-pixbuf, glib, gnome-desktop3, gst-plugins-base, gst-plugins-good, gstreamer, gtk3, libarchive, libcairo, libgxps, libhandy, libsecret, libspectre, libtiff, libxml2, pango, poppler, poppler-data, texlive-bin"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner"
NEOTERM_PKG_RECOMMENDS="evince-help"
NEOTERM_PKG_DISABLE_GIR=false
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dnautilus=false
-Dps=enabled
-Dgtk_doc=false
-Dintrospection=true
-Dgspell=disabled
"

neoterm_step_pre_configure() {
	NEOTERM_PKG_VERSION=. neoterm_setup_gir
}
