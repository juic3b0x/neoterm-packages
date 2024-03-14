NEOTERM_PKG_HOMEPAGE=http://openbox.org/wiki/ObConf:About
NEOTERM_PKG_DESCRIPTION="A configuration tool for the Openbox window manager"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.0.4
NEOTERM_PKG_REVISION=30
NEOTERM_PKG_SRCURL=http://openbox.org/dist/obconf/obconf-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=71a3e5f4ee246a27421ba85044f09d449f8de22680944ece9c471cd46a9356b9
NEOTERM_PKG_DEPENDS="gdk-pixbuf, glib, gtk2, libglade, libx11, libxml2, openbox, startup-notification"

neoterm_step_pre_configure() {
	export LIBS="-lgmodule-2.0"
}
