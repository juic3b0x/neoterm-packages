# x11-packages
NEOTERM_PKG_HOMEPAGE=https://github.com/Enselic/recordmydesktop
NEOTERM_PKG_DESCRIPTION="GTK frontend to recordMyDesktop"
NEOTERM_PKG_LICENSE="GPL-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.4.0
NEOTERM_PKG_SRCURL=https://github.com/Enselic/recordmydesktop/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=69602d32c1be82cd92083152c7c44c0206ca0d6419d76a6144ffcfe07b157a72
NEOTERM_PKG_DEPENDS="gtk3, pygobject, python, recordmydesktop"
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_RM_AFTER_INSTALL="lib/locale"

_PYTHON_VERSION=$(. $NEOTERM_SCRIPTDIR/packages/python/build.sh; echo $_MAJOR_VERSION)

NEOTERM_PKG_EXTRA_CONFIGURE_ARGS="
am_cv_python_pythondir=$NEOTERM_PREFIX/lib/python${_PYTHON_VERSION}/site-packages
"

neoterm_step_post_get_source() {
	NEOTERM_PKG_SRCDIR+="/gtk-recordmydesktop"
}

neoterm_step_pre_configure() {
	autoreconf -fi

	neoterm_setup_python_crossenv
	pushd $NEOTERM_PYTHON_CROSSENV_SRCDIR
	_CROSSENV_PREFIX=$NEOTERM_PKG_BUILDDIR/python-crossenv-prefix
	python${_PYTHON_VERSION} -m crossenv \
		$NEOTERM_PREFIX/bin/python${_PYTHON_VERSION} \
		${_CROSSENV_PREFIX}
	popd
	. ${_CROSSENV_PREFIX}/bin/activate
}
