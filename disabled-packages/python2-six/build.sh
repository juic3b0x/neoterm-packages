# x11-packages
NEOTERM_PKG_HOMEPAGE=https://pypi.org/project/six/
NEOTERM_PKG_DESCRIPTION="Python 2 and 3 compatibility utilities"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.12.0
NEOTERM_PKG_REVISION=23
NEOTERM_PKG_SRCURL=https://pypi.io/packages/source/s/six/six-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=d16a0141ec1a18405cd4ce8b4613101da75da0e9a7aec5bdd4fa804d0e0eba73
NEOTERM_PKG_DEPENDS="python2"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_PLATFORM_INDEPENDENT=true

neoterm_step_make() {
	return
}

neoterm_step_make_install() {
	export PYTHONPATH=${NEOTERM_PREFIX}/lib/python2.7/site-packages/
	python2.7 setup.py install --prefix="${NEOTERM_PREFIX}" --force
}
