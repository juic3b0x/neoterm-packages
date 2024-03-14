NEOTERM_PKG_HOMEPAGE=https://scipy.org/
NEOTERM_PKG_DESCRIPTION="Fundamental algorithms for scientific computing in Python"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.12.0"
NEOTERM_PKG_SRCURL=git+https://github.com/scipy/scipy
NEOTERM_PKG_DEPENDS="libc++, libopenblas, python, python-numpy"
NEOTERM_PKG_BUILD_DEPENDS="python-numpy-static"
NEOTERM_PKG_PYTHON_COMMON_DEPS="wheel, 'Cython>=3.0.4', meson-python, build"
_NUMPY_VERSION=$(. $NEOTERM_SCRIPTDIR/packages/python-numpy/build.sh; echo $NEOTERM_PKG_VERSION)
NEOTERM_PKG_PYTHON_BUILD_DEPS="'pybind11>=2.10.4', 'numpy==$_NUMPY_VERSION'"
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="latest-release-tag"

NEOTERM_PKG_BLACKLISTED_ARCHES="arm, i686"

NEOTERM_MESON_WHEEL_CROSSFILE="$NEOTERM_PKG_TMPDIR/wheel-cross-file.txt"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
-Dfortran_std=none
-Dblas=openblas
-Dlapack=openblas
-Duse-pythran=false
--cross-file $NEOTERM_MESON_WHEEL_CROSSFILE
"

NEOTERM_PKG_RM_AFTER_INSTALL="
bin/
"

neoterm_step_pre_configure() {
	if $NEOTERM_ON_DEVICE_BUILD; then
		neoterm_error_exit "Package '$NEOTERM_PKG_NAME' is not available for on-device builds."
	fi

	neoterm_setup_flang

	# Use a wrapper FC
	mkdir -p $NEOTERM_PKG_TMPDIR/_fake_bin
	sed -e "s|@NEOTERM_PREFIX@|${NEOTERM_PREFIX}|g" \
		-e "s|@COMPILER@|$(command -v ${FC})|g" \
		"$NEOTERM_PKG_BUILDER_DIR"/wrapper.py.in \
		> $NEOTERM_PKG_TMPDIR/_fake_bin/"$(basename ${FC})"
	chmod +x $NEOTERM_PKG_TMPDIR/_fake_bin/"$(basename ${FC})"
	export PATH="$NEOTERM_PKG_TMPDIR/_fake_bin:$PATH"
}

neoterm_step_configure() {
	neoterm_setup_meson

	cp -f $NEOTERM_MESON_CROSSFILE $NEOTERM_MESON_WHEEL_CROSSFILE
	sed -i 's|^\(\[binaries\]\)$|\1\npython = '\'$(command -v python)\''|g' \
		$NEOTERM_MESON_WHEEL_CROSSFILE
	sed -i 's|^\(\[properties\]\)$|\1\nnumpy-include-dir = '\'$PYTHON_SITE_PKG/numpy/core/include\''|g' \
		$NEOTERM_MESON_WHEEL_CROSSFILE

	neoterm_step_configure_meson
}

neoterm_step_make() {
	pushd $NEOTERM_PKG_SRCDIR
	python -m build -w -n -x --config-setting builddir=$NEOTERM_PKG_BUILDDIR .
	popd
}

neoterm_step_make_install() {
	local _pyv="${NEOTERM_PYTHON_VERSION/./}"
	local _whl="scipy-$NEOTERM_PKG_VERSION-cp$_pyv-cp$_pyv-linux_$NEOTERM_ARCH.whl"
	pip install --no-deps --prefix=$NEOTERM_PREFIX $NEOTERM_PKG_SRCDIR/dist/$_whl
}
