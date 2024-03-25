NEOTERM_PKG_HOMEPAGE=https://0pointer.de/lennart/projects/libdaemon/
NEOTERM_PKG_DESCRIPTION="A lightweight C library that eases the writing of UNIX daemons"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.14
NEOTERM_PKG_SRCURL=https://0pointer.de/lennart/projects/libdaemon/libdaemon-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=fd23eb5f6f986dcc7e708307355ba3289abe03cc381fc47a80bca4a50aa6b834
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_func_setpgrp_void=yes"

neoterm_step_pre_configure() {
	autoreconf -fi
}
