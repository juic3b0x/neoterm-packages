NEOTERM_PKG_HOMEPAGE=http://enet.bespin.org
NEOTERM_PKG_DESCRIPTION="ENet reliable UDP networking library"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@ravener"
NEOTERM_PKG_VERSION=1.3.17
NEOTERM_PKG_SRCURL=http://enet.bespin.org/download/enet-${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=a38f0f194555d558533b8b15c0c478e946310022d0ec7b34334e19e4574dcedc

neoterm_step_pre_configure() {
	autoreconf -vfi
}
