NEOTERM_PKG_HOMEPAGE=https://cointop.sh/
NEOTERM_PKG_DESCRIPTION="A fast and lightweight interactive terminal based UI application for tracking cryptocurrencies"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.6.10
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://github.com/cointop-sh/cointop/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=18da0d25288deec7156ddd1d6923960968ab4adcdc917f85726b97d555d9b1b7
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="build VERSION=${NEOTERM_PKG_VERSION#*:}"

neoterm_step_pre_configure() {
	neoterm_setup_golang

	go mod init || :
	go mod tidy
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin bin/cointop
}
