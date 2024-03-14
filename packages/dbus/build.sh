NEOTERM_PKG_HOMEPAGE=https://dbus.freedesktop.org
NEOTERM_PKG_DESCRIPTION="Freedesktop.org message bus system"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.15.6
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL="https://dbus.freedesktop.org/releases/dbus/dbus-$NEOTERM_PKG_VERSION.tar.xz"
NEOTERM_PKG_SHA256=f97f5845f9c4a5a1fb3df67dfa9e16b5a3fd545d348d6dc850cb7ccc9942bd8c
NEOTERM_PKG_DEPENDS="libexpat, libx11"
NEOTERM_PKG_BREAKS="dbus-dev"
NEOTERM_PKG_REPLACES="dbus-dev"
NEOTERM_PKG_BUILD_IN_SRC=true

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_func_close_range=no
--disable-libaudit
--disable-systemd
--disable-tests
--enable-x11-autolaunch
--with-test-socket-dir=$NEOTERM_PREFIX/tmp
--with-session-socket-dir=$NEOTERM_PREFIX/tmp
--with-x=auto
"

neoterm_step_pre_configure() {
	export LIBS="-llog"
}

neoterm_step_create_debscripts() {
	{
		echo "#!${NEOTERM_PREFIX}/bin/sh"
		echo "if [ ! -e ${NEOTERM_PREFIX}/var/lib/dbus/machine-id ]; then"
		echo "mkdir -p ${NEOTERM_PREFIX}/var/lib/dbus"
		echo "dbus-uuidgen > ${NEOTERM_PREFIX}/var/lib/dbus/machine-id"
		echo "fi"
		echo "exit 0"
	} > postinst
}
