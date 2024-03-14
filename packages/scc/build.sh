NEOTERM_PKG_HOMEPAGE=https://github.com/boyter/scc
NEOTERM_PKG_DESCRIPTION="Counts physical the lines of code, blank lines, comment lines, and physical lines of source code"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="3.2.0"
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://github.com/boyter/scc/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=69cce0b57e66c736169bd07943cdbe70891bc2ff3ada1f4482acbd1335adbfad
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	neoterm_setup_golang

	go mod init || :
	go mod tidy
	go build
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin scc
}
