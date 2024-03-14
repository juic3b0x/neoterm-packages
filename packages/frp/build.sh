NEOTERM_PKG_HOMEPAGE=https://gofrp.org/doc
NEOTERM_PKG_DESCRIPTION="A fast reverse proxy to expose a local server behind a NAT or firewall to the internet"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="2096779623 <admin@uneoterm.dev>"
NEOTERM_PKG_VERSION="0.54.0"
NEOTERM_PKG_SRCURL=https://github.com/fatedier/frp/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=c09d8610b5eb02c0b1851459ace7751fe80a06b2373a6d5d40631a08e8ac64ae
NEOTERM_PKG_REPLACES="frpc, frps"
NEOTERM_PKG_BREAKS="frpc, frps"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_golang
	make frpc
	make frps
}

neoterm_step_make_install() {
	install -Dm700 -t "${NEOTERM_PREFIX}"/bin bin/frpc
	install -Dm700 -t "${NEOTERM_PREFIX}"/bin bin/frps
}
