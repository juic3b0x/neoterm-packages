NEOTERM_PKG_HOMEPAGE=https://github.com/akavel/up
NEOTERM_PKG_DESCRIPTION="Helps interactively and incrementally explore textual data in Linux"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.4
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=git+https://github.com/akavel/up
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	neoterm_setup_golang

	go mod init || :
	go mod tidy
	go build
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin up
}
