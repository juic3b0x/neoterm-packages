NEOTERM_PKG_HOMEPAGE=https://github.com/0l1v3rr/cli-file-manager
NEOTERM_PKG_DESCRIPTION="A basic file manager that runs inside a terminal, designed for Linux. It's fully responsive and incredibly fast."
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.2.0"
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL="https://github.com/0l1v3rr/cli-file-manager/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz"
NEOTERM_PKG_SHA256=1a955225a72e822b9a1a1e13edbb460770e7102206050560919de4420cb1474a
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_pre_configure() {
	neoterm_setup_golang

	go mod init || :
	go mod tidy
}

neoterm_step_make() {
	make build
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin bin/cfm
}
