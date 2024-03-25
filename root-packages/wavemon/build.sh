NEOTERM_PKG_HOMEPAGE=https://github.com/uoaerg/wavemon
NEOTERM_PKG_DESCRIPTION="Ncurses-based monitoring application for wireless network devices"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.9.5"
NEOTERM_PKG_SRCURL=https://github.com/uoaerg/wavemon/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=f84c55a40b470f2b98908d20cd0b38ffef6f587daed23b50281c9592df3331c6
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libcap, libnl, libnl-cli, ncurses"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_lib_pthread_pthread_create=yes"

neoterm_step_pre_configure() {
	CPPFLAGS+=" -I$NEOTERM_PREFIX/include/libnl3"
}
