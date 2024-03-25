# x11-packages
NEOTERM_PKG_HOMEPAGE=https://github.com/python-xlib/python-xlib
NEOTERM_PKG_DESCRIPTION="A fully functional X client library for Python programs"
NEOTERM_PKG_LICENSE="LGPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.24
NEOTERM_PKG_REVISION=23
NEOTERM_PKG_SRCURL=https://github.com/python-xlib/python-xlib/releases/download/${NEOTERM_PKG_VERSION}/python-xlib-${NEOTERM_PKG_VERSION}.tar.bz2
NEOTERM_PKG_SHA256=7ecf32b18b59be2c06848410bae848792ead119ac31084f487730581b3ab598c
NEOTERM_PKG_DEPENDS="libx11, python2, python2-six"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

neoterm_step_make() {
	return
}

neoterm_step_make_install() {
	## python2 setuptools needed
	export PYTHONPATH=${NEOTERM_PREFIX}/lib/python2.7/site-packages/
	python2.7 setup.py install --root="/" --prefix="${NEOTERM_PREFIX}" --force
}
