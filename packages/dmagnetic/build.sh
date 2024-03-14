NEOTERM_PKG_HOMEPAGE=https://dettus.net/dMagnetic
NEOTERM_PKG_DESCRIPTION="Interpreter for classic text adventure games and interactive fiction"
NEOTERM_PKG_LICENSE="BSD 2-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.37
NEOTERM_PKG_SRCURL=https://dettus.net/dMagnetic/dMagnetic_${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=ad812bb515bc972e23930d643d5abeaed971d550768b1b3f371bd0f72c3c2e89
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_HOSTBUILD=true
NEOTERM_PKG_GROUPS="games"

neoterm_step_host_build() {
	cd $NEOTERM_PKG_BUILDDIR
	make -j $NEOTERM_MAKE_PROCESSES dMagnetic
	mv dMagnetic $NEOTERM_PKG_HOSTBUILD_DIR/
	make clean
}

neoterm_step_post_configure() {
	# find our host-built dMagnetic
	export PATH=$NEOTERM_PKG_HOSTBUILD_DIR:$PATH
}

neoterm_step_post_make_install() {
	sed "s%@NEOTERM_PREFIX@%$NEOTERM_PREFIX%g" \
	    $NEOTERM_PKG_BUILDER_DIR/magnetic-scrolls.in \
	    > $NEOTERM_PREFIX/bin/magnetic-scrolls
	chmod 700 $NEOTERM_PREFIX/bin/magnetic-scrolls
}
