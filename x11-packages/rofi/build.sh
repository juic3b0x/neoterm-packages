NEOTERM_PKG_HOMEPAGE=https://github.com/DaveDavenport/rofi
NEOTERM_PKG_DESCRIPTION="A window switcher, application launcher and dmenu replacement"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="Tristan Ross <spaceboyross@yandex.com>"
NEOTERM_PKG_VERSION=1.7.5
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL="https://github.com/DaveDavenport/rofi/releases/download/$NEOTERM_PKG_VERSION/rofi-$NEOTERM_PKG_VERSION.tar.xz"
NEOTERM_PKG_SHA256=caffcf66d165cb32b748c1db7f229d6d75da58c1685eb17455f65c60e8220c8d
NEOTERM_PKG_DEPENDS="gdk-pixbuf, glib, libandroid-glob, libcairo, libxcb, libxkbcommon, pango, startup-notification, xcb-util, xcb-util-cursor, xcb-util-wm"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--disable-check"

neoterm_step_pre_configure() {
	export LIBS="-landroid-glob"
	export GLIB_GENMARSHAL=glib-genmarshal
	export GOBJECT_QUERY=gobject-query
	export GLIB_MKENUMS=glib-mkenums
	export GLIB_COMPILE_RESOURCES=glib-compile-resources
}
