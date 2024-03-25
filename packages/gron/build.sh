NEOTERM_PKG_HOMEPAGE=https://github.com/tomnomnom/gron
NEOTERM_PKG_DESCRIPTION="Transforms JSON into discrete assignments"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.7.1
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=git+https://github.com/tomnomnom/gron
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_golang

	go mod init || :
	go mod tidy
	go build
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin gron
}
