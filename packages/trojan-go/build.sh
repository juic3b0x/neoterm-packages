NEOTERM_PKG_HOMEPAGE=https://p4gefau1t.github.io/trojan-go
NEOTERM_PKG_DESCRIPTION="A Trojan proxy written in Go. An unidentifiable mechanism that helps you bypass GFW"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.10.6"
NEOTERM_PKG_REVISION=3
NEOTERM_PKG_SRCURL=https://github.com/p4gefau1t/trojan-go/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=925f02647dda944813f1eab0b71eac98b83eb5964ef5a6f63e89bc7eb4486c1f
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_pre_configure() {
	neoterm_setup_golang

	go mod init || :
	go mod tidy -compat=1.17
}

neoterm_step_make() {
	go build -tags "full"
}

neoterm_step_make_install() {
	install -Dm700 -t "${NEOTERM_PREFIX}"/bin trojan-go
}
