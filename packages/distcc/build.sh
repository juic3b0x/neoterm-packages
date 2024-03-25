NEOTERM_PKG_HOMEPAGE=http://distcc.org/
NEOTERM_PKG_DESCRIPTION="Distributed C/C++ compiler"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.4
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://github.com/distcc/distcc/releases/download/v$NEOTERM_PKG_VERSION/distcc-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=2b99edda9dad9dbf283933a02eace6de7423fe5650daa4a728c950e5cd37bd7d
NEOTERM_PKG_DEPENDS="libpopt"
NEOTERM_PKG_BUILD_IN_SRC=true

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-pump-mode
--without-avahi
--without-gtk
--without-libiberty"

neoterm_step_pre_configure() {
	./autogen.sh
	export LIBS="-llog"
}
