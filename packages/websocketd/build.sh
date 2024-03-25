NEOTERM_PKG_HOMEPAGE=http://websocketd.com/
NEOTERM_PKG_DESCRIPTION="Turn any program that uses STDIN/STDOUT into a WebSocket server"
NEOTERM_PKG_LICENSE="BSD 2-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.4.1"
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://github.com/joewalnes/websocketd/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=6b8fe0fad586d794e002340ee597059b2cfc734ba7579933263aef4743138fe5
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_pre_configure() {
	neoterm_setup_golang

	go mod init || :
	go mod tidy 
}

neoterm_step_make() {
	go build -o websocketd -ldflags "-X main.version=${NEOTERM_PKG_VERSION} -X main.buildinfo=$(date +%s)-@neoterm-${GOARCH}"
}

neoterm_step_make_install() {
	install -Dm700 -t "${NEOTERM_PREFIX}"/bin websocketd
}
