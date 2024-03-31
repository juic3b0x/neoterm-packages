NEOTERM_PKG_HOMEPAGE=https://wiki.gnome.org/Apps/EyeOfGnome
NEOTERM_PKG_DESCRIPTION="Eye of GNOME, an image viewing and cataloging program"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
_MAJOR_VERSION=44
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.3
NEOTERM_PKG_SRCURL=https://download.gnome.org/sources/eog/${_MAJOR_VERSION}/eog-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=d6b2d70f4b432ff8cf494c8f9029b2621d08e7817938317d64063ae6c4da9d8c
NEOTERM_PKG_DEPENDS="gdk-pixbuf, glib, gnome-desktop3, gobject-introspection, gsettings-desktop-schemas, gtk3, libcairo, libexif, libhandy, libjpeg-turbo, libpeas, librsvg, libx11, littlecms, shared-mime-info, zlib"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner"
NEOTERM_PKG_RECOMMENDS="eog-help"
NEOTERM_PKG_DISABLE_GIR=false
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dxmp=false
-Dintrospection=true
-Dlibportal=false
"

neoterm_step_pre_configure() {
	neoterm_setup_gir
}
