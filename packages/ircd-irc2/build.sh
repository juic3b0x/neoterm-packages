NEOTERM_PKG_HOMEPAGE=http://www.irc.org/
NEOTERM_PKG_DESCRIPTION="An Internet Relay Chat (IRC) daemon"
NEOTERM_PKG_LICENSE="GPL-2.0" # GPL-1.0-or-later
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.11.2p3
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=http://www.irc.org/ftp/irc/server/irc${NEOTERM_PKG_VERSION}.tgz
NEOTERM_PKG_SHA256=be94051845f9be7da0e558699c4af7963af7e647745d339351985a697eca2c81
NEOTERM_PKG_DEPENDS="libcrypt, resolv-conf"
NEOTERM_PKG_BUILD_IN_SRC=true

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--mandir=$NEOTERM_PREFIX/share/man
--with-resconf=$NEOTERM_PREFIX/etc/resolv.conf
ac_cv_func_setpgrp_void=yes
irc_cv_non_blocking_system=posix
"
NEOTERM_PKG_EXTRA_MAKE_ARGS="-C build"

neoterm_step_pre_configure() {
	CFLAGS+=" $CPPFLAGS"
	LDFLAGS+=" -lcrypt"
}
