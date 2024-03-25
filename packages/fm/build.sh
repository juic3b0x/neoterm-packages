NEOTERM_PKG_HOMEPAGE=https://github.com/knipferrc/fm
NEOTERM_PKG_DESCRIPTION="A terminal based file manager"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.16.0"
NEOTERM_PKG_SRCURL=https://github.com/knipferrc/fm/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=a07b783e1dbb98a12924beae4928e84069c5023ede8d16339409af613c02b666
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_pre_configure() {
	neoterm_setup_golang

	go mod init || :
	go mod tidy
}

neoterm_step_make() {
	go build
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin fm
}
