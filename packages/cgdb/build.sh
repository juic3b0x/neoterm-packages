NEOTERM_PKG_HOMEPAGE=https://cgdb.github.io/
NEOTERM_PKG_DESCRIPTION="A lightweight curses (terminal-based) interface to the GNU Debugger (GDB)"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.8.0
NEOTERM_PKG_SRCURL=https://cgdb.me/files/cgdb-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=0d38b524d377257b106bad6d856d8ae3304140e1ee24085343e6ddf1b65811f1
NEOTERM_PKG_DEPENDS="libc++, ncurses, readline, gdb"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_lib_ncursesw6_addnwstr=yes ac_cv_file__dev_ptmx=yes
ac_cv_func_setpgrp_void=true ac_cv_rl_version=7
ac_cv_file__proc_self_status=yes
"
NEOTERM_PKG_RM_AFTER_INSTALL="share/applications share/pixmaps"
