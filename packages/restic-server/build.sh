TERMUX_PKG_HOMEPAGE=https://restic.net/
TERMUX_PKG_DESCRIPTION="Restic's REST backend API server"
TERMUX_PKG_LICENSE="BSD 2-Clause"
TERMUX_PKG_MAINTAINER="@neoterm"
TERMUX_PKG_VERSION="0.12.1"
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://github.com/restic/rest-server/archive/v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=cfbeb4a66cac6fc36b1cb11256f06c6e4fcc7a28c2ef590550adf1c199b9aa4b
TERMUX_PKG_BUILD_IN_SRC=true
TERMUX_PKG_AUTO_UPDATE=true

termux_step_make() {
	termux_setup_golang
	_GOARCH="${GOARCH}"
	unset GOOS GOARCH
	go run build.go \
		--enable-cgo \
		--goos android \
		--goarch "${_GOARCH}"
}

termux_step_make_install() {
	install -Dm755 rest-server "${TERMUX_PREFIX}/bin/rest-server"
}
