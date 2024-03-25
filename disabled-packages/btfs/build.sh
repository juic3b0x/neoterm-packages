NEOTERM_PKG_HOMEPAGE=https://www.bittorrent.com/btfs/
NEOTERM_PKG_DESCRIPTION="Decentralized file system integrating with TRON network"
NEOTERM_PKG_LICENSE="Apache-2.0, MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=1.6.0
NEOTERM_PKG_SRCURL=https://github.com/TRON-US/go-btfs/archive/refs/tags/btfs-v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=27de546a83f2c7655a0dbe2bc12e6a8ca7c05ab52f1246263667396fd374f83e
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
NEOTERM_PKG_BUILD_IN_SRC=true

neoterm_step_make() {
	neoterm_setup_golang
	export GOPATH=$NEOTERM_PKG_CACHEDIR/go

	make build
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin $NEOTERM_PKG_SRCDIR/cmd/btfs/btfs
}
