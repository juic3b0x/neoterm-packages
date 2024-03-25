NEOTERM_PKG_HOMEPAGE=https://www.riverbankcomputing.com/software/pyqtwebengine/
NEOTERM_PKG_DESCRIPTION="Python Bindings for the Qt WebEngine Framework"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=5.15.6
NEOTERM_PKG_SRCURL=https://files.pythonhosted.org/packages/source/P/PyQtWebEngine/PyQtWebEngine-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=ae241ef2a61c782939c58b52c2aea53ad99b30f3934c8358d5e0a6ebb3fd0721
NEOTERM_PKG_DEPENDS="libc++, pyqt5, python, qt5-qtbase, qt5-qtwebengine"
NEOTERM_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools"
NEOTERM_PKG_PYTHON_COMMON_DEPS="wheel, PyQt-builder"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="
--verbose
--scripts-dir=$NEOTERM_PREFIX/bin
--qmake=$NEOTERM_PREFIX/opt/qt/cross/bin/qmake
"

neoterm_step_pre_configure() {
	local _cxx=$(basename $CXX)
	local _bindir=$NEOTERM_PKG_BUILDDIR/_wrapper/bin
	mkdir -p ${_bindir}
	sed -e 's|@CXX@|'"$(command -v $CXX)"'|g' \
		-e 's|@NEOTERM_PREFIX@|'"${NEOTERM_PREFIX}"'|g' \
		-e 's|@PYTHON_VERSION@|'"${NEOTERM_PYTHON_VERSION}"'|g' \
		$NEOTERM_PKG_BUILDER_DIR/cxx-wrapper > ${_bindir}/${_cxx}
	chmod 0700 ${_bindir}/${_cxx}
	export PATH=${_bindir}:$PATH

	NEOTERM_PKG_EXTRA_MAKE_ARGS+=" --target-dir=$NEOTERM_PYTHON_HOME/site-packages"
}

neoterm_step_make() {
	python ${NEOTERM_PYTHON_CROSSENV_PREFIX}/build/bin/sip-build \
		--jobs ${NEOTERM_MAKE_PROCESSES} \
		${NEOTERM_PKG_EXTRA_MAKE_ARGS}
}

neoterm_step_make_install() {
	make -C build install
}
