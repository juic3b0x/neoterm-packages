NEOTERM_PKG_HOMEPAGE=https://numpy.org/
NEOTERM_PKG_DESCRIPTION="The fundamental package for scientific computing with Python"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.26.4"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=git+https://github.com/numpy/numpy
NEOTERM_PKG_DEPENDS="libc++, libopenblas, python"
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_TAG_TYPE="latest-release-tag"
NEOTERM_PKG_PYTHON_COMMON_DEPS="wheel, 'Cython>=0.29.34,<3.1', 'meson-python>=0.15.0,<0.16.0', build"

NEOTERM_MESON_WHEEL_CROSSFILE="$NEOTERM_PKG_TMPDIR/wheel-cross-file.txt"
NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
--cross-file $NEOTERM_MESON_WHEEL_CROSSFILE
"

NEOTERM_PKG_RM_AFTER_INSTALL="
bin/
"

neoterm_step_pre_configure() {
	if $NEOTERM_ON_DEVICE_BUILD; then
		neoterm_error_exit "Package '$NEOTERM_PKG_NAME' is not available for on-device builds."
	fi

	LDFLAGS+=" -lm"
}

neoterm_step_configure() {
	neoterm_setup_meson

	cp -f $NEOTERM_MESON_CROSSFILE $NEOTERM_MESON_WHEEL_CROSSFILE
	sed -i 's|^\(\[binaries\]\)$|\1\npython = '\'$(command -v python)\''|g' \
		$NEOTERM_MESON_WHEEL_CROSSFILE
	sed -i 's|^\(\[properties\]\)$|\1\nnumpy-include-dir = '\'$PYTHON_SITE_PKG/numpy/core/include\''|g' \
		$NEOTERM_MESON_WHEEL_CROSSFILE

	local _longdouble_format=""
	if [ $NEOTERM_ARCH_BITS = 32 ]; then
		_longdouble_format="IEEE_DOUBLE_LE"
	else
		_longdouble_format="IEEE_QUAD_LE"
	fi
	sed -i 's|^\(\[properties\]\)$|\1\nlongdouble_format = '\'$_longdouble_format\''|g' \
		$NEOTERM_MESON_WHEEL_CROSSFILE

	local _meson_buildtype="minsize"
	local _meson_stripflag="--strip"
	if [ "$NEOTERM_DEBUG_BUILD" = "true" ]; then
		_meson_buildtype="debug"
		_meson_stripflag=
	fi

	local _custom_meson="build-python $NEOTERM_PKG_SRCDIR/vendored-meson/meson/meson.py"
	CC=gcc CXX=g++ CFLAGS= CXXFLAGS= CPPFLAGS= LDFLAGS= $_custom_meson \
		$NEOTERM_PKG_SRCDIR \
		$NEOTERM_PKG_BUILDDIR \
		--cross-file $NEOTERM_MESON_CROSSFILE \
		--prefix $NEOTERM_PREFIX \
		--libdir lib \
		--buildtype ${_meson_buildtype} \
		${_meson_stripflag} \
		$NEOTERM_PKG_EXTRA_CONFIGURE_ARGS
}

neoterm_step_make() {
	pushd $NEOTERM_PKG_SRCDIR
	python -m build -w -n -x --config-setting builddir=$NEOTERM_PKG_BUILDDIR .
	popd
}

neoterm_step_make_install() {
	local _pyv="${NEOTERM_PYTHON_VERSION/./}"
	local _whl="numpy-$NEOTERM_PKG_VERSION-cp$_pyv-cp$_pyv-linux_$NEOTERM_ARCH.whl"
	pip install --no-deps --prefix=$NEOTERM_PREFIX --force-reinstall $NEOTERM_PKG_SRCDIR/dist/$_whl
}
