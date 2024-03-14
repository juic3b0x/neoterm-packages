NEOTERM_PKG_HOMEPAGE=https://docs.xfce.org/apps/notifyd/start
NEOTERM_PKG_DESCRIPTION="simple, visually-appealing notification daemon for Xfce"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="Yisus7u7 <dev.yisus@hotmail.com>"
NEOTERM_PKG_VERSION="0.9.3"
NEOTERM_PKG_SRCURL=https://archive.xfce.org/src/apps/xfce4-notifyd/${NEOTERM_PKG_VERSION%.*}/xfce4-notifyd-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=79ee4701e2f8715a700de2431aa33682933cab18d76938bb18e2820302bbe030
NEOTERM_PKG_DEPENDS="atk, gdk-pixbuf, glib, gtk3, harfbuzz, libcairo, libnotify, libsqlite, libx11, libxfce4ui, libxfce4util, pango, xfce4-panel, xfconf, zlib"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	export GLIB_MKENUMS=$(command -v glib-mkenums)
	export GLIB_GENMARSHAL=$(command -v glib-genmarshal)
	export GLIB_COMPILE_RESOURCES=$(command -v glib-compile-resources)
	export GDBUS_CODEGEN=$(command -v gdbus-codegen)
}
