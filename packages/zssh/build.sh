NEOTERM_PKG_HOMEPAGE=https://zssh.sourceforge.net/
NEOTERM_PKG_DESCRIPTION="A program for interactively transferring files to a remote machine while using the secure shell (ssh)"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.5c
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/zssh/zssh-${NEOTERM_PKG_VERSION}.tgz
NEOTERM_PKG_SHA256=a2e840f82590690d27ea1ea1141af509ee34681fede897e58ae8d354701ce71b
NEOTERM_PKG_DEPENDS="libandroid-glob, lrzsz, openssh, readline"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	autoreconf -fi

	echo "ac_cv_func_getpgrp_void=yes" >> config.cache
	LDFLAGS+=" -landroid-glob"
}
