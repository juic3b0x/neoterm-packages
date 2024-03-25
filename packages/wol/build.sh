NEOTERM_PKG_HOMEPAGE=https://sourceforge.net/projects/wake-on-lan/
NEOTERM_PKG_DESCRIPTION="Program implementing Wake On LAN functionality"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.7.1
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/project/wake-on-lan/wol/${NEOTERM_PKG_VERSION}/wol-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=e0086c9b9811df2bdf763ec9016dfb1bcb7dba9fa6d7858725b0929069a12622
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="--mandir=$NEOTERM_PREFIX/share/man"
NEOTERM_PKG_RM_AFTER_INSTALL="info/"

neoterm_step_pre_configure() {
	export ac_cv_func_mmap_fixed_mapped=yes
	export jm_cv_func_working_malloc=yes
	export ac_cv_func_alloca_works=yes
}
