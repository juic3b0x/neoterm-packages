NEOTERM_PKG_HOMEPAGE=https://github.com/xtaci/kcptun
NEOTERM_PKG_DESCRIPTION="A Stable & Secure Tunnel based on KCP with N:M multiplexing and FEC"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="20240107"
NEOTERM_PKG_SRCURL=https://github.com/xtaci/kcptun/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=4a21033a3558fc9089303505457eead5366af961a7cd56f1856e54ef4d65a1e7
NEOTERM_PKG_REPLACES="kcptun-client, kcptun-server"
NEOTERM_PKG_BREAKS="kcptun-client, kcptun-server"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_golang
	LDFLAGS="-X main.VERSION=${NEOTERM_PKG_VERSION#*:} -s -w"
	GCFLAGS=""

	go build -mod=vendor -ldflags "$LDFLAGS" -gcflags "$GCFLAGS" -o kcptun-client github.com/xtaci/kcptun/client
	go build -mod=vendor -ldflags "$LDFLAGS" -gcflags "$GCFLAGS" -o kcptun-server github.com/xtaci/kcptun/server
}

neoterm_step_make_install() {
	install -Dm700 -t "${NEOTERM_PREFIX}"/bin kcptun-client
	install -Dm700 -t "${NEOTERM_PREFIX}"/bin kcptun-server

}
