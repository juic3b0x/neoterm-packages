NEOTERM_PKG_HOMEPAGE=https://pandas.pydata.org/
NEOTERM_PKG_DESCRIPTION="Powerful Python data analysis toolkit"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.5.3
NEOTERM_PKG_SRCURL=https://github.com/pandas-dev/pandas/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=d8abf9c2bf33cac75b28f32c174c29778414eb249e5e2ccb69b1079b97a8fc66
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="libc++, python, python-numpy, python-pip"
NEOTERM_PKG_PYTHON_COMMON_DEPS="Cython, numpy, wheel"
NEOTERM_PKG_PYTHON_TARGET_DEPS="python-dateutil, pytz"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	LDFLAGS+=" -lm"
}

neoterm_step_make_install() {
	pip install --no-deps --no-build-isolation . --prefix $NEOTERM_PREFIX
}

neoterm_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/sh
	echo "Installing dependencies through pip..."
	pip3 install ${NEOTERM_PKG_PYTHON_TARGET_DEPS//, / }
	EOF
}
