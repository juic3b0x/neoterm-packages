NEOTERM_PKG_HOMEPAGE=https://www.xfce.org/
NEOTERM_PKG_DESCRIPTION="Window manager for XFCE environment"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
_MAJOR_VERSION=4.18
NEOTERM_PKG_VERSION=${_MAJOR_VERSION}.0
NEOTERM_PKG_SRCURL=https://archive.xfce.org/src/xfce/xfwm4/${_MAJOR_VERSION}/xfwm4-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=92cd1b889bb25cb4bc06c1c6736c238d96e79c1e706b9f77fad0a89d6e5fc13f
NEOTERM_PKG_DEPENDS="gdk-pixbuf, glib, gtk3, libcairo, libepoxy, libwnck, libx11, libxcomposite, libxdamage, libxext, libxfce4ui, libxfce4util, libxfixes, libxinerama, libxrandr, libxrender, pango, startup-notification, xfconf"
NEOTERM_PKG_RECOMMENDS="hicolor-icon-theme"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-startup-notification
--enable-randr
--enable-compositor
--enable-xsync
"
