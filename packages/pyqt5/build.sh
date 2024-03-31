NEOTERM_PKG_HOMEPAGE=https://www.riverbankcomputing.com/software/pyqt/
NEOTERM_PKG_DESCRIPTION="Comprehensive Python Bindings for Qt v5"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="5.15.10"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://files.pythonhosted.org/packages/source/P/PyQt5/PyQt5-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=d46b7804b1b10a4ff91753f8113e5b5580d2b4462f3226288e2d84497334898a
NEOTERM_PKG_DEPENDS="libc++, python, qt5-qtbase, qt5-qtdeclarative, qt5-qtlocation, qt5-qtmultimedia, qt5-qtsensors, qt5-qtsvg, qt5-qttools, qt5-qtwebchannel, qt5-qtwebkit, qt5-qtwebsockets, qt5-qtx11extras, qt5-qtxmlpatterns, python-pip"
NEOTERM_PKG_BUILD_DEPENDS="qt5-qtbase-cross-tools, qt5-qtdeclarative-cross-tools, qt5-qttools-cross-tools"
NEOTERM_PKG_PYTHON_COMMON_DEPS="wheel, PyQt-builder"
NEOTERM_PKG_PYTHON_TARGET_DEPS="PyQt5-sip"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="
--verbose
--scripts-dir=$NEOTERM_PREFIX/bin
--confirm-license
--qmake=$NEOTERM_PREFIX/opt/qt/cross/bin/qmake
"

# ```
# /home/builder/.neoterm-build/pyqt5/src/sip/QtQuick/qsggeometry.sip:136:30:
# error: use of undeclared identifier 'GL_BYTE'
#			 case GL_BYTE:
#			      ^
# /home/builder/.neoterm-build/pyqt5/src/sip/QtQuick/qsggeometry.sip:148:30:
# error: use of undeclared identifier 'GL_FLOAT'
#			 case GL_FLOAT:
#			      ^
# /home/builder/.neoterm-build/pyqt5/src/sip/QtQuick/qsggeometry.sip:152:30:
# error: use of undeclared identifier 'GL_INT'
#			 case GL_INT:
#			      ^
# 3 errors generated.
# ```
NEOTERM_PKG_EXTRA_MAKE_ARGS+=" --disable=QtQuick"

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

	local f
	for f in pylupdate5 pyrcc5 pyuic5; do
		local t="$NEOTERM_PREFIX/bin/${f}"
		rm -f "${t}"
		sed -e 's|@NEOTERM_PREFIX@|'"${NEOTERM_PREFIX}"'|g' \
			"$NEOTERM_PKG_BUILDER_DIR/${f}.in" > "${t}"
		chmod 0700 "${t}"
	done
}

neoterm_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/sh
	echo "Installing dependencies through pip..."
	pip3 install $NEOTERM_PKG_PYTHON_TARGET_DEPS
	EOF
}
