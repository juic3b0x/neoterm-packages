NEOTERM_PKG_HOMEPAGE=https://dbus.freedesktop.org
NEOTERM_PKG_DESCRIPTION="GLib bindings for DBUS"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.112
NEOTERM_PKG_REVISION=4
NEOTERM_PKG_SRCURL="https://dbus.freedesktop.org/releases/dbus-glib/dbus-glib-$NEOTERM_PKG_VERSION.tar.gz"
NEOTERM_PKG_SHA256=7d550dccdfcd286e33895501829ed971eeb65c614e73aadb4a08aeef719b143a
NEOTERM_PKG_DEPENDS="dbus, glib"
NEOTERM_PKG_BREAKS="dbus-glib-dev"
NEOTERM_PKG_REPLACES="dbus-glib-dev"
NEOTERM_PKG_HOSTBUILD=true

neoterm_step_host_build() {
	(cd $NEOTERM_PKG_SRCDIR && autoconf -i)
	$NEOTERM_PKG_SRCDIR/configure
	make -j $NEOTERM_MAKE_PROCESSES
}

neoterm_step_pre_configure() {
	export GLIB_GENMARSHAL=glib-genmarshal
	autoconf -i
	NEOTERM_PKG_EXTRA_CONFIGURE_ARGS+=" --with-dbus-binding-tool=$NEOTERM_PKG_HOSTBUILD_DIR/dbus/dbus-binding-tool"
}
