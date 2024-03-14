NEOTERM_PKG_HOMEPAGE=https://tmate.io
NEOTERM_PKG_DESCRIPTION="Terminal multiplexer with instant terminal sharing"
NEOTERM_PKG_LICENSE="ISC"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.4.0
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://github.com/tmate-io/tmate/archive/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=62b61eb12ab394012c861f6b48ba0bc04ac8765abca13bdde5a4d9105cb16138
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libandroid-support, libevent, libmsgpack, libssh, ncurses"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--disable-static"

neoterm_step_pre_configure() {
	CFLAGS+=" -DIOV_MAX=1024"

	./autogen.sh
}
