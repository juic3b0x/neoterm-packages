NEOTERM_PKG_HOMEPAGE=https://github.com/kha7iq/pingme
NEOTERM_PKG_DESCRIPTION="A small utility which can be called from anywhere to send a message with particular information"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.2.6"
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://github.com/kha7iq/pingme/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=5a199ddee57685593efb7ada85b4ff6534098dbab9c67eb1023c1d9416f50de3
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	neoterm_setup_golang

	go mod init || :
	go mod tidy
}

neoterm_step_make() {
	go build
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin pingme
}
