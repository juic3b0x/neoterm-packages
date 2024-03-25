NEOTERM_PKG_HOMEPAGE=https://docs.xfce.org/apps/terminal/start
NEOTERM_PKG_DESCRIPTION="Terminal Emulator for the XFCE environment"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.1.3"
NEOTERM_PKG_SRCURL=https://archive.xfce.org/src/apps/xfce4-terminal/${NEOTERM_PKG_VERSION%.*}/xfce4-terminal-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=214dd588d441b69f816009682a3bb4652cc19bed7ea64b612a12f097417b3d45
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="gdk-pixbuf, glib, gtk3, libcairo, libvte, libx11, libxfce4ui, libxfce4util, pango, xfconf"
NEOTERM_PKG_RECOMMENDS="desktop-file-utils, hicolor-icon-theme"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--enable-gtk-doc-html=no"
