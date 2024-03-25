NEOTERM_PKG_HOMEPAGE=https://geth.ethereum.org/
NEOTERM_PKG_DESCRIPTION="Go implementation of the Ethereum protocol"
NEOTERM_PKG_LICENSE="LGPL-3.0, GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="1.13.14"
NEOTERM_PKG_SRCURL=https://github.com/ethereum/go-ethereum/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=629723fa82c629581ccada149c05d2fdbcbba04ad783042d4cabe59434c4759d
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_SUGGESTS="geth-utils"

neoterm_step_make() {
	neoterm_setup_golang

	export GOPATH=$NEOTERM_PKG_BUILDDIR
	mkdir -p "${GOPATH}"/src/github.com/ethereum
	ln -sf "$NEOTERM_PKG_SRCDIR" "$GOPATH"/src/github.com/ethereum/go-ethereum

	cd "$GOPATH"/src/github.com/ethereum/go-ethereum
	for applet in abidump abigen bootnode clef devp2p ethkey evm geth p2psim rlpdump; do
		go -C ./cmd/"$applet" build -v
	done
	unset applet
}

neoterm_step_make_install() {
	for applet in abidump abigen bootnode clef devp2p ethkey evm geth p2psim rlpdump; do
		install -Dm700 \
			"$NEOTERM_PKG_SRCDIR/cmd/$applet/$applet" \
			"$NEOTERM_PREFIX"/bin/
	done
	unset applet
}
