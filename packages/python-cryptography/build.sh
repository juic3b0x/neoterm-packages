NEOTERM_PKG_HOMEPAGE=https://github.com/pyca/cryptography
NEOTERM_PKG_DESCRIPTION="Provides cryptographic recipes and primitives to Python developers"
NEOTERM_PKG_LICENSE="Apache-2.0, BSD 3-Clause"
NEOTERM_PKG_LICENSE_FILE="LICENSE, LICENSE.APACHE, LICENSE.BSD"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="42.0.5"
NEOTERM_PKG_SRCURL=https://github.com/pyca/cryptography/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=f2ac59a6419ec7ba9b586fbd6a5eb487b6de71dd0633a51f6ca3f0c74aca086a
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="openssl, python, python-pip"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_UPDATE_TAG_TYPE="newest-tag"
NEOTERM_PKG_PYTHON_COMMON_DEPS="wheel, cffi, setuptools-rust"
NEOTERM_PKG_PYTHON_TARGET_DEPS="'cffi>=1.12'"

neoterm_step_configure() {
	neoterm_setup_rust
	export CARGO_BUILD_TARGET=${CARGO_TARGET_NAME}
	export PYO3_CROSS_LIB_DIR=$NEOTERM_PREFIX/lib
}

neoterm_step_create_debscripts() {
	cat <<- EOF > ./postinst
	#!$NEOTERM_PREFIX/bin/sh
	echo "Installing dependencies through pip..."
	pip3 install $NEOTERM_PKG_PYTHON_TARGET_DEPS
	EOF
}
