NEOTERM_PKG_HOMEPAGE=https://github.com/RasmusLindroth/tut
NEOTERM_PKG_DESCRIPTION="A TUI for Mastodon with vim inspired keys"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.0.1"
NEOTERM_PKG_REVISION=2
NEOTERM_PKG_SRCURL=https://github.com/RasmusLindroth/tut/archive/refs/tags/${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=afa8c49036461a36c091d83ef51f9a3bbd938ee78f817c6467175699a989b863
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
	install -Dm700 -t $NEOTERM_PREFIX/bin tut
	install -Dm600 -t $NEOTERM_PREFIX/share/doc/$NEOTERM_PKG_NAME config.example.toml
}
