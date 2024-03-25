NEOTERM_PKG_HOMEPAGE=https://www.panda3d.org/
NEOTERM_PKG_DESCRIPTION="A framework for 3D rendering and game development for Python and C++ programs"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.10.13
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/panda3d/panda3d/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=b865882d8cbb44e7a9b1e030ecc071e689391644eb68b0d8ed78b970e8d4d2c7
NEOTERM_PKG_DEPENDS="libc++, python"
NEOTERM_PKG_BUILD_DEPENDS="libandroid-glob"
NEOTERM_PKG_PYTHON_COMMON_DEPS="wheel"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	CFLAGS+=" $CPPFLAGS"
	CXXFLAGS+=" $CPPFLAGS"
	LDFLAGS+=" -Wl,-rpath=$NEOTERM_PREFIX/lib/panda3d"
}

neoterm_step_make() {
	python makepanda/makepanda.py --nothing
}

neoterm_step_make_install() {
	python makepanda/installpanda.py --prefix $NEOTERM_PREFIX
}
