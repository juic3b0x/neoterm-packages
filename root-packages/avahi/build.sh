NEOTERM_PKG_HOMEPAGE=https://www.avahi.org/
NEOTERM_PKG_DESCRIPTION="A system for service discovery on a local network via mDNS/DNS-SD"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.8
NEOTERM_PKG_REVISION=9
NEOTERM_PKG_SRCURL=https://github.com/lathiat/avahi/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=c15e750ef7c6df595fb5f2ce10cac0fee2353649600e6919ad08ae8871e4945f
NEOTERM_PKG_DEPENDS="dbus, glib, libandroid-glob, libdaemon, libevent, libexpat, resolv-conf"

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--enable-compat-libdns_sd
--enable-dbus
--disable-gdbm
--disable-gtk3
--disable-mono
--disable-pygobject
--disable-python
--disable-python-dbus
--disable-qt5
--with-distro=none
ac_cv_func_chroot=no
"
neoterm_step_pre_configure() {
	autoreconf -fi
	LDFLAGS+=" -landroid-glob"
}

neoterm_step_post_make_install() {
	ln -sf avahi-compat-libdns_sd/dns_sd.h $NEOTERM_PREFIX/include/dns_sd.h
}
