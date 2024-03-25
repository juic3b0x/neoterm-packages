NEOTERM_PKG_HOMEPAGE=https://github.com/xxf098/LiteSpeedTest
NEOTERM_PKG_DESCRIPTION="A simple tool for batch test ss/ssr/v2ray/trojan servers"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.15.0"
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/xxf098/LiteSpeedTest/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=93da1b6ca132a779b4ce754802699c6ecc6817739603e505c8f7c12cf97c69c9
NEOTERM_PKG_DEPENDS="resolv-conf"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_EXTRA_MAKE_ARGS="VERSION=$NEOTERM_PKG_VERSION"
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_pre_configure() {
	neoterm_setup_golang

	go mod init || :
	go mod tidy
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin bin/lite
}
