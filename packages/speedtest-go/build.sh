NEOTERM_PKG_HOMEPAGE=https://github.com/showwin/speedtest-go/
NEOTERM_PKG_DESCRIPTION="Command line interface to test internet speed using speedtest.net"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.6.10"
NEOTERM_PKG_SRCURL=https://github.com/showwin/speedtest-go/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=3f2d6ae3b60d8b6e972038fd2e13f3fdeca75647d88785d65bfa0d99a2f4fd79
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
	install -Dm700 -t $NEOTERM_PREFIX/bin speedtest-go
}
