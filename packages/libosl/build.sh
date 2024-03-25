NEOTERM_PKG_HOMEPAGE="http://icps.u-strasbg.fr/~bastoul/development/openscop"
NEOTERM_PKG_DESCRIPTION="A Specification and a Library for Data Exchange in Polyhedral Compilation Tools"
NEOTERM_PKG_GROUPS="science"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.9.7"
NEOTERM_PKG_SRCURL="https://github.com/periscop/openscop/archive/refs/tags/$NEOTERM_PKG_VERSION.tar.gz"
NEOTERM_PKG_SHA256=bdb566af5c68cb8bb66dc204b1dcafebaa843a25dfdbcc64dfcc21a1912c3e66
NEOTERM_PKG_DEPENDS="libgmp"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_post_get_source() {
	rm -f CMakeLists.txt
}
neoterm_step_pre_configure() {
	autoreconf -fi
}
