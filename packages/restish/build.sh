NEOTERM_PKG_HOMEPAGE="https://github.com/danielgtaylor/restish"
NEOTERM_PKG_DESCRIPTION="A CLI for interacting with REST-ish HTTP APIs"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_LICENSE_FILE="LICENSE.md"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.20.0"
NEOTERM_PKG_SRCURL="https://github.com/danielgtaylor/restish/archive/v$NEOTERM_PKG_VERSION.tar.gz"
NEOTERM_PKG_SHA256=0aebd5eaf4b34870e40c8b94a0cc84ef65c32fde32eddae48e9529c73a31176d
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	neoterm_setup_golang

	go mod init || :
	go mod tidy

	go build
}

neoterm_step_make_install() {
	install -Dm755 -t "${NEOTERM_PREFIX}/bin" restish
}
