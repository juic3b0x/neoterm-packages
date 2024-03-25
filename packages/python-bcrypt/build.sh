NEOTERM_PKG_HOMEPAGE=https://github.com/pyca/bcrypt
NEOTERM_PKG_DESCRIPTION="Acceptable password hashing for your software and your servers"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="4.1.2"
NEOTERM_PKG_SRCURL=https://pypi.io/packages/source/b/bcrypt/bcrypt-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=33313a1200a3ae90b75587ceac502b048b840fc69e7f7a0905b5f87fac7a1258
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_DEPENDS="python"
NEOTERM_PKG_BUILD_DEPENDS="openssl"
NEOTERM_PKG_PYTHON_COMMON_DEPS="wheel, setuptools-rust"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	neoterm_setup_rust
}

neoterm_step_post_configure() {
	export CARGO_BUILD_TARGET=${CARGO_TARGET_NAME}
	export PYO3_CROSS_LIB_DIR=$NEOTERM_PREFIX/lib
}
