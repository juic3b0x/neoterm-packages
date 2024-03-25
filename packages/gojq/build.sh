NEOTERM_PKG_HOMEPAGE=https://github.com/itchyny/gojq
NEOTERM_PKG_DESCRIPTION="Pure Go implementation of jq"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.12.14"
NEOTERM_PKG_SRCURL=https://github.com/itchyny/gojq/archive/refs/tags/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=973cb65ee9f4353c8b103812c10afd122b00ab8711db53842ffd44e211bca494
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_golang
	go mod tidy
	go build -o gojq ./cmd/gojq
}

neoterm_step_make_install() {
	install -Dm700 -t "$NEOTERM_PREFIX/bin" gojq
}
