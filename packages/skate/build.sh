NEOTERM_PKG_HOMEPAGE=https://github.com/charmbracelet/skate
NEOTERM_PKG_DESCRIPTION="A personal key-value store"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.2.2
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/charmbracelet/skate/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=e982348a89a54c0f9fafe855ec705c91b12eb3bb9aceb70b37abf7504106b04e
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
	install -Dm700 -t $NEOTERM_PREFIX/bin skate
}
