NEOTERM_PKG_HOMEPAGE=https://gts.sourceforge.net/
NEOTERM_PKG_DESCRIPTION="Provides useful functions to deal with 3D surfaces meshed with interconnected triangles"
NEOTERM_PKG_LICENSE="LGPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.7.6
NEOTERM_PKG_SRCURL=https://downloads.sourceforge.net/project/gts/gts/${NEOTERM_PKG_VERSION}/gts-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=059c3e13e3e3b796d775ec9f96abdce8f2b3b5144df8514eda0cc12e13e8b81e
NEOTERM_PKG_DEPENDS="glib"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_HOSTBUILD=true

neoterm_step_host_build() {
	# predicates_init executable generates predicates_init.h
	$NEOTERM_PKG_SRCDIR/configure
	make -C src predicates_init
}
