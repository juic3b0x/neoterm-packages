NEOTERM_PKG_HOMEPAGE=https://github.com/python-xlib/python-xlib
NEOTERM_PKG_DESCRIPTION="The Python X Library"
NEOTERM_PKG_LICENSE="LGPL-2.1"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.33
NEOTERM_PKG_SRCURL=https://github.com/python-xlib/python-xlib/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=e10d1b49655800bffe0fbb5eb31eeef915a4421952ef006d468d53d34901f6f8
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="python, python-pip"
NEOTERM_PKG_PYTHON_COMMON_DEPS="wheel"
NEOTERM_PKG_PYTHON_TARGET_DEPS="'six>=1.10.0'"
NEOTERM_PKG_PLATFORM_INDEPENDENT=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/sh
	echo "Installing dependencies through pip. This may take a while..."
	pip3 install ${NEOTERM_PKG_PYTHON_TARGET_DEPS//, / }
	EOF
}
