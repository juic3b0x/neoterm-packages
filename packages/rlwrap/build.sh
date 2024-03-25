NEOTERM_PKG_HOMEPAGE=https://github.com/hanslub42/rlwrap
NEOTERM_PKG_DESCRIPTION="Wrapper using readline to enable editing of keyboard input for commands"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.46.1
NEOTERM_PKG_SRCURL=https://fossies.org/linux/privat/rlwrap-${NEOTERM_PKG_VERSION}.tar.xz
NEOTERM_PKG_SHA256=fa00682947fd30e97bf09af3d1feb69cb04cb60676fc23be1e266208b65241b5
NEOTERM_PKG_DEPENDS="ncurses, readline"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_func_grantpt=yes
ac_cv_func_unlockpt=yes
ac_cv_lib_util_openpty=no
ptyttylib_cv_ptys=STREAMS
"

neoterm_step_pre_configure() {
	autoreconf -vfi
}
