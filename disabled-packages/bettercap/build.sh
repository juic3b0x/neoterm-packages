# root-packages
NEOTERM_PKG_HOMEPAGE=https://www.bettercap.org
NEOTERM_PKG_DESCRIPTION="The Swiss Army knife for 802.11, BLE and Ethernet networks reconnaissance and MITM attacks"
NEOTERM_PKG_LICENSE="GPL-3.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.32.0
NEOTERM_PKG_REVISION=1
NEOTERM_PKG_SRCURL=https://github.com/bettercap/bettercap/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=ea28d4d533776a328a54723a74101d1720016ffe7d434bf1d7ab222adb397ac6
NEOTERM_PKG_DEPENDS="libpcap, libusb, libnetfilter-queue"

neoterm_step_configure() {
	neoterm_setup_golang
	export GOPATH=$NEOTERM_PKG_BUILDDIR	
	export CGO_CFLAGS="-I$NEOTERM_PREFIX/include"

	mkdir -p "$GOPATH"/src/github.com/bettercap/
	cp -a "$NEOTERM_PKG_SRCDIR" "$GOPATH"/src/github.com/bettercap/bettercap
	go get github.com/bettercap/recording
}

neoterm_step_make() {
	cd src/github.com/bettercap/bettercap
	make build
}

neoterm_step_make_install() {
	cd src/github.com/bettercap/bettercap
	make install
}
