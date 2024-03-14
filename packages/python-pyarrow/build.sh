NEOTERM_PKG_HOMEPAGE=https://github.com/apache/arrow
NEOTERM_PKG_DESCRIPTION="Python bindings for Apache Arrow"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
# Align the version with `libarrow-cpp` package.
NEOTERM_PKG_VERSION=15.0.1
NEOTERM_PKG_SRCURL=https://github.com/apache/arrow/archive/refs/tags/apache-arrow-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=a8b154a2870aa998019baeb22a6514477918a5831d4760a85b516cb4c9a3402a
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_METHOD=repology
NEOTERM_PKG_DEPENDS="libarrow-cpp (>= ${NEOTERM_PKG_VERSION}), libc++, python, python-numpy"
NEOTERM_PKG_PYTHON_COMMON_DEPS="Cython, numpy, wheel"
NEOTERM_PKG_PROVIDES="libarrow-python"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	echo "Applying setup.py.diff"
	sed -e "s|@VERSION@|${NEOTERM_PKG_VERSION#*:}|g" \
		$NEOTERM_PKG_BUILDER_DIR/setup.py.diff \
		| patch --silent -p1

	NEOTERM_PKG_SRCDIR+="/python"
	NEOTERM_PKG_BUILDDIR="$NEOTERM_PKG_SRCDIR"

	export PYARROW_CMAKE_OPTIONS="
		-DCMAKE_PREFIX_PATH=$NEOTERM_PREFIX/lib/cmake
		-DNUMPY_INCLUDE_DIRS=$NEOTERM_PYTHON_HOME/site-packages/numpy/core/include
		"
	export PYARROW_WITH_DATASET=1
	export PYARROW_WITH_HDFS=1
	export PYARROW_WITH_ORC=1
	export PYARROW_WITH_PARQUET=1
}

neoterm_step_configure() {
	# cmake is not intended to be invoked directly.
	neoterm_setup_cmake
	neoterm_setup_ninja
}

neoterm_step_make_install() {
	pip install --no-deps --no-build-isolation . --prefix $NEOTERM_PREFIX
}

neoterm_step_post_make_install() {
	local f="$NEOTERM_PYTHON_HOME/site-packages/pyarrow/_generated_version.py"
	if [ ! -e "${f}" ]; then
		echo "version = '${NEOTERM_PKG_VERSION#*:}'" > "${f}"
	fi
}
