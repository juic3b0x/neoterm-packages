NEOTERM_PKG_HOMEPAGE=https://wiki.gnome.org/Projects/Clutter
NEOTERM_PKG_DESCRIPTION="A library providing facilities to integrate Clutter into GTK+ applications and vice versa"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
_MAJOR_VERSION=1.8
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.4
NEOTERM_PKG_SRCURL=https://download.gnome.org/sources/clutter-gtk/${_MAJOR_VERSION}/clutter-gtk-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=521493ec038973c77edcb8bc5eac23eed41645117894aaee7300b2487cb42b06
NEOTERM_PKG_DEPENDS="atk, clutter, cogl, fontconfig, freetype, gdk-pixbuf, glib, gtk3, harfbuzz, json-glib, libcairo, libx11, libxcomposite, libxdamage, libxext, libxfixes, libxi, libxrandr, pango"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner"
NEOTERM_PKG_DISABLE_GIR=false
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-introspection=yes
"

neoterm_step_pre_configure() {
	neoterm_setup_gir
}
