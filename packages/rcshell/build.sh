NEOTERM_PKG_HOMEPAGE=http://tobold.org/article/rc
NEOTERM_PKG_DESCRIPTION="An alternative implementation of the plan 9 rc shell"
NEOTERM_PKG_LICENSE="ZLIB"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.7.4
NEOTERM_PKG_REVISION=4
NEOTERM_PKG_SRCURL=https://sources.voidlinux-ppc.org/rc-${NEOTERM_PKG_VERSION}/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=0b83f8698dd8ef44ca97b25c4748c087133f53c7fff39b6b70dab65931def8b0
NEOTERM_PKG_DEPENDS="readline"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_HOSTBUILD=true

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
ac_cv_func_setpgrp_void=yes
rc_cv_sysv_sigcld=no
"

neoterm_step_host_build() {
	(cd $NEOTERM_PKG_SRCDIR && autoreconf -vfi)
	$NEOTERM_PKG_SRCDIR/configure
	make mksignal mkstatval
}

neoterm_step_pre_configure() {
	autoreconf -vfi
	cp $NEOTERM_PKG_HOSTBUILD_DIR/{mksignal,mkstatval} $NEOTERM_PKG_BUILDDIR/
	touch -d 'next hour' $NEOTERM_PKG_BUILDDIR/{mksignal,mkstatval}
}
