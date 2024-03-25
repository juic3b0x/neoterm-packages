NEOTERM_PKG_HOMEPAGE=https://www.cloudwego.io
NEOTERM_PKG_DESCRIPTION="A high-performance and strong-extensibility Go HTTP framework that helps developers build microservices"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.8.1"
NEOTERM_PKG_SRCURL=https://github.com/cloudwego/hertz/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=c0d300a0b2f963cefa77a99e9eb7c865ab21fee2e4be6294d59e46b80f8bcb2f
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_pre_configure() {
	cd "$NEOTERM_PKG_SRCDIR"/cmd/hz

	neoterm_setup_golang

	go mod init || :
	go mod tidy
}

neoterm_step_make() {
	cd "$NEOTERM_PKG_SRCDIR"/cmd/hz
	go build -o hz
}

neoterm_step_make_install() {
	install -Dm700 -t "${NEOTERM_PREFIX}"/bin "$NEOTERM_PKG_SRCDIR"/cmd/hz/hz
}
