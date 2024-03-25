NEOTERM_PKG_HOMEPAGE=https://www.gnome.org/
NEOTERM_PKG_DESCRIPTION="Allows you to load glade interface files in a program at runtime"
NEOTERM_PKG_LICENSE="LGPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.6.4
NEOTERM_PKG_REVISION=24
NEOTERM_PKG_SRCURL=https://download.gnome.org/sources/libglade/2.6/libglade-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=64361e7647839d36ed8336d992fd210d3e8139882269bed47dc4674980165dec
NEOTERM_PKG_DEPENDS="atk, fontconfig, freetype, gdk-pixbuf, glib, gtk2, libcairo, libxml2, pango"
NEOTERM_PKG_RM_AFTER_INSTALL="share/gtk-doc"

# For libglade-convert.
NEOTERM_PKG_SUGGESTS="python2"

neoterm_step_pre_configure() {
	export LIBS="-lgmodule-2.0"
}

neoterm_step_post_make_install() {
	sed \
		-i "s|#!/usr/bin/python|#!${NEOTERM_PREFIX}/bin/python2|g" \
		"${NEOTERM_PREFIX}/bin/libglade-convert"
}
