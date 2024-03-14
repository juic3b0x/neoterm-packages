NEOTERM_PKG_HOMEPAGE=https://www.bittorrent.com/btfs/
NEOTERM_PKG_DESCRIPTION="Decentralized file system integrating with TRON network and Bittorrent network"
NEOTERM_PKG_LICENSE="Apache-2.0, MIT"
NEOTERM_PKG_LICENSE_FILE="LICENSE-APACHE, LICENSE-MIT"
NEOTERM_PKG_MAINTAINER="Simbad Marino <cctechmx@gmail.com>"
NEOTERM_PKG_VERSION="2.3.4"
NEOTERM_PKG_SRCURL=https://github.com/bittorrent/go-btfs/archive/refs/tags/btfs-v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=6b252117f63c94c98ec83eba3267e24c7fec0a3c642964ea95965cb463778467
NEOTERM_PKG_AUTO_UPDATE=true
NEOTERM_PKG_UPDATE_VERSION_REGEXP="\d+\.\d+\.\d+"
NEOTERM_PKG_DEPENDS="libc++"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_CONFLICTS="btfs"
NEOTERM_PKG_REPLACES="btfs"

neoterm_setup_golang_119() {
	if [ "$NEOTERM_ON_DEVICE_BUILD" = "false" ]; then
		local NEOTERM_GO_VERSION=go1.19.13
		local NEOTERM_GO_SHA256=4643d4c29c55f53fa0349367d7f1bb5ca554ea6ef528c146825b0f8464e2e668
		local NEOTERM_GO_PLATFORM=linux-amd64

		local NEOTERM_BUILDGO_FOLDER="${NEOTERM_PKG_CACHEDIR}/${NEOTERM_GO_VERSION}"

		export GOROOT=$NEOTERM_BUILDGO_FOLDER
		export PATH="${GOROOT}/bin:${PATH}"

		if [ -d "$NEOTERM_BUILDGO_FOLDER" ]; then return; fi

		local NEOTERM_BUILDGO_TAR=$NEOTERM_PKG_CACHEDIR/${NEOTERM_GO_VERSION}.${NEOTERM_GO_PLATFORM}.tar.gz
		rm -Rf "$NEOTERM_PKG_CACHEDIR/go" "$NEOTERM_BUILDGO_FOLDER"
		neoterm_download https://golang.org/dl/${NEOTERM_GO_VERSION}.${NEOTERM_GO_PLATFORM}.tar.gz \
			"$NEOTERM_BUILDGO_TAR" \
			"$NEOTERM_GO_SHA256"

		( cd "$NEOTERM_PKG_CACHEDIR"; tar xf "$NEOTERM_BUILDGO_TAR"; 
		( cd go; . ${NEOTERM_PKG_BUILDER_DIR}/fix-hardcoded-etc-resolv-conf.sh )
		  mv go "$NEOTERM_BUILDGO_FOLDER"; rm "$NEOTERM_BUILDGO_TAR" )
	else
		neoterm_error_exit "This package cannot build on device currently."
	fi
}

neoterm_step_pre_configure() {
	neoterm_setup_golang_119

	go mod init || :
	go mod tidy
}

neoterm_step_make() {
	make build
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin $NEOTERM_PKG_SRCDIR/cmd/btfs/btfs
	ln -sfT btfs $NEOTERM_PREFIX/bin/btfs2
}
