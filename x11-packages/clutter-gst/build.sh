NEOTERM_PKG_HOMEPAGE=https://wiki.gnome.org/Projects/Clutter
NEOTERM_PKG_DESCRIPTION="An integration library for using GStreamer with Clutter"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
_MAJOR_VERSION=3.0
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.27
NEOTERM_PKG_SRCURL=https://download.gnome.org/sources/clutter-gst/${_MAJOR_VERSION}/clutter-gst-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=fe69bd6c659d24ab30da3f091eb91cd1970026d431179b0724f13791e8ad9f9d
NEOTERM_PKG_DEPENDS="atk, clutter, cogl, fontconfig, freetype, gdk-pixbuf, glib, gst-plugins-base, gstreamer, gtk3, harfbuzz, json-glib, libcairo, libx11, libxcomposite, libxdamage, libxext, libxfixes, libxi, libxrandr, pango"
NEOTERM_PKG_BUILD_DEPENDS="g-ir-scanner"
NEOTERM_PKG_DISABLE_GIR=false
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-introspection=yes
"

neoterm_step_pre_configure() {
	neoterm_setup_gir
}

neoterm_step_post_configure() {
	touch clutter-gst/g-ir-{compiler,scanner}
}
