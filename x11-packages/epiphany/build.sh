NEOTERM_PKG_HOMEPAGE=https://wiki.gnome.org/Apps/Web
NEOTERM_PKG_DESCRIPTION="A GNOME web browser based on the WebKit rendering engine"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
_MAJOR_VERSION=44
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.5
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://download.gnome.org/sources/epiphany/${_MAJOR_VERSION}/epiphany-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=3c475e04ed2a0f410cb44b96937563697079193ac9b7a50c91485fb9b08315ab
NEOTERM_PKG_DEPENDS="adwaita-icon-theme, gcr4, gdk-pixbuf, glib, graphene, gsettings-desktop-schemas, gstreamer, gtk4, iso-codes, json-glib, libadwaita, libarchive, libcairo, libgmp, libnettle, libportal-gtk4, libsecret, libsoup3, libsqlite, libxml2, pango, webkitgtk-6.0"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dunit_tests=disabled
"
