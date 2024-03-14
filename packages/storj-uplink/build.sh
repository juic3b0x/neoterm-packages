NEOTERM_PKG_HOMEPAGE=https://www.storj.io/integrations/uplink-cli
NEOTERM_PKG_DESCRIPTION="Storj DCS Uplink CLI"
NEOTERM_PKG_LICENSE="AGPL-V3"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.96.6"
NEOTERM_PKG_SRCURL=https://github.com/storj/storj/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=3b8c56ab1578ca5a615a3f7f0bde23dd15376e1a7babf9f72b6e4c15b55d725f
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_pre_configure() {
	neoterm_setup_golang

	go mod init || :
	go mod tidy
}

neoterm_step_make() {
	go build ./cmd/uplink
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin uplink
}
