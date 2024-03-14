NEOTERM_PKG_HOMEPAGE=https://www.xfce.org/
NEOTERM_PKG_DESCRIPTION="A desktop manager for XFCE environment"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
_MAJOR_VERSION=4.18
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.1
NEOTERM_PKG_SRCURL=https://archive.xfce.org/src/xfce/xfdesktop/${_MAJOR_VERSION}/xfdesktop-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=ef9268190c25877e22a9ff5aa31cc8ede120239cb0dfca080c174e7eed4ff756
NEOTERM_PKG_DEPENDS="exo, garcon, gdk-pixbuf, glib, gtk3, libcairo, libnotify, libwnck, libx11, libxfce4ui, libxfce4util, pango, thunar, xfconf"
NEOTERM_PKG_RECOMMENDS="hicolor-icon-theme"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-notifications
"
