NEOTERM_PKG_HOMEPAGE=https://github.com/chrisstaite/lameenc
NEOTERM_PKG_DESCRIPTION="Python bindings around the LAME encoder"
NEOTERM_PKG_LICENSE="LGPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.7.0"
NEOTERM_PKG_SRCURL=https://github.com/chrisstaite/lameenc/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=0255d5bf4f777f4e17cd4b1d862dcec82a9023d720bdedee20b3106f9d3d25f3
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libmp3lame, python"
NEOTERM_PKG_PYTHON_COMMON_DEPS="wheel"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	rm -rf build dist
}

neoterm_step_configure() {
	:
}

neoterm_step_make() {
	python setup.py \
		--libdir=$NEOTERM_PREFIX/lib \
		--incdir=$NEOTERM_PREFIX/include/lame \
		bdist_wheel
}

neoterm_step_make_install() {
	local f
	for f in dist/lameenc-${NEOTERM_PKG_VERSION#*:}-*.whl; do
		if [ -e "${f}" ]; then
			pip install --force "${f}" --prefix $NEOTERM_PREFIX
			break
		fi
	done
}
