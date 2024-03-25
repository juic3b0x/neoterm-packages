NEOTERM_PKG_HOMEPAGE=https://www.xfce.org/
NEOTERM_PKG_DESCRIPTION="Settings manager for XFCE environment"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="4.18.4"
NEOTERM_PKG_SRCURL=https://archive.xfce.org/src/xfce/xfce4-settings/${NEOTERM_PKG_VERSION%.*}/xfce4-settings-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=f10c55d0360308d9944f415645d9596d4352f952a20fc7c4a66f30fe511ca1dc
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="atk, exo, fontconfig, garcon, gdk-pixbuf, glib, gtk3, libcairo, libnotify, libx11, libxcursor, libxfce4ui, libxfce4util, libxi, libxklavier, libxrandr, pango, xfconf"
NEOTERM_PKG_RECOMMENDS="gsettings-desktop-schemas, libcanberra, lxde-icon-theme"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-xrandr
--enable-xcursor
--enable-libnotify
--enable-libxklavier
--enable-pluggable-dialogs
--enable-sound-settings
"
