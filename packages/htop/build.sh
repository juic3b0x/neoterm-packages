NEOTERM_PKG_HOMEPAGE=https://htop.dev/
NEOTERM_PKG_DESCRIPTION="Interactive process viewer for Linux"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=3.2.2
NEOTERM_PKG_SRCURL=https://github.com/htop-dev/htop/archive/${NEOTERM_PKG_VERSION}/htop-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=3829c742a835a0426db41bb039d1b976420c21ec65e93b35cd9bfd2d57f44ac8
# htop checks setlocale() return value for UTF-8 support, so use libandroid-support.
NEOTERM_PKG_DEPENDS="libandroid-support, ncurses"
NEOTERM_PKG_BREAKS="htop-legacy"
NEOTERM_PKG_CONFLICTS="htop-legacy"
NEOTERM_PKG_REPLACES="htop-legacy"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_RM_AFTER_INSTALL="share/applications share/pixmaps"

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--disable-static
ac_cv_lib_ncursesw6_addnwstr=yes
LIBS=-landroid-support
"

neoterm_step_pre_configure() {
	./autogen.sh
}

neoterm_step_post_make_install() {
	mkdir $NEOTERM_PREFIX/var/htop -p
	cp -a $NEOTERM_PKG_BUILDER_DIR/procstat $NEOTERM_PREFIX/var/htop/stat
}
