NEOTERM_PKG_HOMEPAGE=https://ipfs.io/
NEOTERM_PKG_DESCRIPTION="A peer-to-peer hypermedia distribution protocol"
NEOTERM_PKG_LICENSE="MIT, Apache-2.0"
NEOTERM_PKG_LICENSE_FILE="LICENSE, LICENSE-APACHE, LICENSE-MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.27.0"
NEOTERM_PKG_SRCURL=https://github.com/ipfs/kubo/releases/download/v${NEOTERM_PKG_VERSION}/kubo-source.tar.gz
NEOTERM_PKG_SHA256=c56555d80529a2065a31bdefd30fc2f835ef476ae66ce8f5069c9bde89f685f6
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_SUGGESTS="neoterm-services"
NEOTERM_PKG_SERVICE_SCRIPT=("ipfs" "[ ! -d \"${NEOTERM_ANDROID_HOME}/.ipfs\" ] && ipfs init --empty-repo 2>&1 && ipfs config --json Swarm.EnableRelayHop false 2>&1 && ipfs config --json Swarm.EnableAutoRelay true 2>&1; exec ipfs daemon --enable-namesys-pubsub 2>&1")

neoterm_step_make() {
	neoterm_setup_golang

	export GOPATH=${NEOTERM_PKG_BUILDDIR}

	mkdir -p "${GOPATH}/src/github.com/ipfs"
	cp -a "${NEOTERM_PKG_SRCDIR}" "${GOPATH}/src/github.com/ipfs/kubo"
	cd "${GOPATH}/src/github.com/ipfs/kubo"

	make build

	# Fix folders without write permissions preventing which fails repeating builds:
	cd "$NEOTERM_PKG_BUILDDIR"
	find . -type d -exec chmod u+w {} \;
}

neoterm_step_make_install() {
	install -Dm700 -t "$NEOTERM_PREFIX"/bin "${NEOTERM_PKG_BUILDDIR}/src/github.com/ipfs/kubo/cmd/ipfs/ipfs"
}
