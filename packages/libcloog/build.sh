NEOTERM_PKG_HOMEPAGE="http://www.bastoul.net/cloog/index.php"
NEOTERM_PKG_DESCRIPTION="Library that generates loops for scanning polyhedra"
NEOTERM_PKG_GROUPS="science"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.21.1"
NEOTERM_PKG_SRCURL="https://github.com/periscop/cloog/archive/refs/tags/cloog-$NEOTERM_PKG_VERSION.tar.gz"
NEOTERM_PKG_SHA256=eace8938416a3240c073bdf935b12d2f9c115ec574d9bcbcc9423fe96ed530eb
NEOTERM_PKG_DEPENDS="libisl, libosl"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--with-isl=system
--with-osl=system
"

neoterm_step_pre_configure() {
	autoreconf -fi
}
