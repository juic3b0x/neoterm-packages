NEOTERM_PKG_HOMEPAGE=https://gitlab.gnome.org/GNOME/glib-networking
NEOTERM_PKG_DESCRIPTION="Network-related giomodules for glib"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.78.1"
NEOTERM_PKG_SRCURL=https://ftp.gnome.org/pub/gnome/sources/glib-networking/${NEOTERM_PKG_VERSION%.*}/glib-networking-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=e48f2ddbb049832cbb09230529c5e45daca9f0df0eda325f832f7379859bf09f
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="glib, libgnutls"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Denvironment_proxy=enabled
-Dlibproxy=disabled
-Dgnome_proxy=disabled
"
