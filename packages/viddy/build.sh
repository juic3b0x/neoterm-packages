NEOTERM_PKG_HOMEPAGE=https://github.com/sachaos/viddy
NEOTERM_PKG_DESCRIPTION="A modern watch command"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.4.0"
NEOTERM_PKG_SRCURL=https://github.com/sachaos/viddy/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=b64cca44ef6367397498faae92296fc005156e6e5a7518b6f64ac2bc912044d0
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	neoterm_setup_golang

	go mod init || :
	go mod tidy
	go build
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin viddy
}
