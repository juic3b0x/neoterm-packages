NEOTERM_PKG_HOMEPAGE=https://gitlab.gnome.org/GNOME/zenity
NEOTERM_PKG_DESCRIPTION="a rewrite of gdialog, the GNOME port of dialog"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
_MAJOR_VERSION=3.44
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.2
NEOTERM_PKG_SRCURL=https://download.gnome.org/sources/zenity/${_MAJOR_VERSION}/zenity-$NEOTERM_PKG_VERSION.tar.xz
NEOTERM_PKG_SHA256=3fb5b8b1044d3d129262d3c54cf220eb7f76bc21bd5ac6d96ec115cd3518300e
NEOTERM_PKG_DEPENDS="gdk-pixbuf, glib, gtk3, libnotify, libx11, pango, webkit2gtk-4.1"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dlibnotify=true
-Dwebkitgtk=true
"
