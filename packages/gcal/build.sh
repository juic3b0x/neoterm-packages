NEOTERM_PKG_HOMEPAGE=https://www.gnu.org/software/gcal/
NEOTERM_PKG_DESCRIPTION="Program for calculating and printing calendars"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=4.1
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://mirrors.kernel.org/gnu/gcal/gcal-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=91b56c40b93eee9bda27ec63e95a6316d848e3ee047b5880ed71e5e8e60f61ab
NEOTERM_PKG_DEPENDS="ncurses"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-threads
ac_cv_header_spawn_h=no
"

neoterm_step_pre_configure() {
	autoreconf -fi
}
