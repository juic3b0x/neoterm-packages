# NOTE: Currently segfaults when running.
NEOTERM_PKG_HOMEPAGE=http://checkinstall.izto.org/
NEOTERM_PKG_DESCRIPTION="Installation tracker creating a package from a local install"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.6.2
NEOTERM_PKG_SRCURL=http://checkinstall.izto.org/files/source/checkinstall-$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256="dc61192cf7b8286d42c44abae6cf594ee52eafc08bfad0bea9d434b73dd593f4"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_DEPENDS="file, make"
NEOTERM_PKG_RM_AFTER_INSTALL="lib/checkinstall/locale/"

neoterm_step_pre_configure() {
	CFLAGS+=" -D__off64_t=off64_t"
	CFLAGS+=" -D_STAT_VER=3"
	CFLAGS+=" -D_MKNOD_VER=1"
	CFLAGS+=" -DS_IREAD=S_IRUSR"
}

neoterm_step_post_make_install() {
	mv $NEOTERM_PREFIX/lib/checkinstall/checkinstallrc-dist \
	   $NEOTERM_PREFIX/lib/checkinstall/checkinstallrc
}
