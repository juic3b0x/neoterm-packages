NEOTERM_PKG_HOMEPAGE=https://restic.net/
NEOTERM_PKG_DESCRIPTION="Restic's REST backend API server"
NEOTERM_PKG_LICENSE="BSD 2-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.12.1"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/restic/rest-server/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=cfbeb4a66cac6fc36b1cb11256f06c6e4fcc7a28c2ef590550adf1c199b9aa4b
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_golang
	_GOARCH="${GOARCH}"
	unset GOOS GOARCH
	go run build.go \
		--enable-cgo \
		--goos android \
		--goarch "${_GOARCH}"
}

neoterm_step_make_install() {
	install -Dm755 rest-server "${NEOTERM_PREFIX}/bin/rest-server"
}
