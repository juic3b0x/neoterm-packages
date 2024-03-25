NEOTERM_PKG_HOMEPAGE=https://www.riverbankcomputing.com/software/qscintilla/
NEOTERM_PKG_DESCRIPTION="Python bindings for QScintilla"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
# Align the version with `qscintilla` package.
NEOTERM_PKG_VERSION=2.14.1
NEOTERM_PKG_SRCURL=https://www.riverbankcomputing.com/static/Downloads/QScintilla/${NEOTERM_PKG_VERSION}/QScintilla_src-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=dfe13c6acc9d85dfcba76ccc8061e71a223957a6c02f3c343b30a9d43a4cdd4d
NEOTERM_PKG_DEPENDS="libc++, pyqt5, python, qscintilla (>= ${NEOTERM_PKG_VERSION}), qt5-qtbase"
NEOTERM_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools"
NEOTERM_PKG_PYTHON_COMMON_DEPS="wheel, PyQt-builder"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="
--verbose
--scripts-dir=$NEOTERM_PREFIX/bin
--qmake=$NEOTERM_PREFIX/opt/qt/cross/bin/qmake
--target-dir=$NEOTERM_PYTHON_HOME/site-packages
"

neoterm_step_pre_configure() {
	NEOTERM_PKG_SRCDIR+="/Python"
	NEOTERM_PKG_BUILDDIR="$NEOTERM_PKG_SRCDIR"
	cd "$NEOTERM_PKG_SRCDIR"

	ln -sf pyproject{-qt5,}.toml

	local h="$NEOTERM_PREFIX/include/Qsci/qsciglobal.h"
	local _CFGTEST_QSCI
	_CFGTEST_QSCI=$(( $(sed -En 's/^#define\s+QSCINTILLA_VERSION\s+([^\s]+).*/\1/p' "${h}") ))
	_CFGTEST_QSCI+=" "
	_CFGTEST_QSCI+=$(sed -En 's/^#define\s+QSCINTILLA_VERSION_STR\s+"([^"]+)".*/\1/p' "${h}")

	local _cxx=$(basename $CXX)
	local _bindir=$NEOTERM_PKG_BUILDDIR/_wrapper/bin
	mkdir -p ${_bindir}
	sed -e 's|@CXX@|'"$(command -v $CXX)"'|g' \
		-e 's|@CFGTEST_QSCI@|'"${_CFGTEST_QSCI}"'|g' \
		-e 's|@NEOTERM_PREFIX@|'"${NEOTERM_PREFIX}"'|g' \
		-e 's|@PYTHON_VERSION@|'"${NEOTERM_PYTHON_VERSION}"'|g' \
		$NEOTERM_PKG_BUILDER_DIR/cxx-wrapper > ${_bindir}/${_cxx}
	chmod 0700 ${_bindir}/${_cxx}
	export PATH=${_bindir}:$PATH
}

neoterm_step_make() {
	python ${NEOTERM_PYTHON_CROSSENV_PREFIX}/build/bin/sip-build \
		--jobs ${NEOTERM_MAKE_PROCESSES} \
		${NEOTERM_PKG_EXTRA_MAKE_ARGS}
}

neoterm_step_make_install() {
	make -C build install
}
