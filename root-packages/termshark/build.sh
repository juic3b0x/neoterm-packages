NEOTERM_PKG_HOMEPAGE=https://termshark.io
NEOTERM_PKG_DESCRIPTION="A terminal UI for tshark, inspired by Wireshark"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.4.0
NEOTERM_PKG_REVISION=4
NEOTERM_PKG_SRCURL=git+https://github.com/gcla/termshark
NEOTERM_PKG_DEPENDS="tshark"

neoterm_step_make() {
	neoterm_setup_golang

	export GOPATH=$NEOTERM_PKG_BUILDDIR
	export GO111MODULE=on

	cd $NEOTERM_PKG_SRCDIR
	go install ./...
}

neoterm_step_make_install() {
	install -Dm700 bin/android_${GOARCH}/termshark $NEOTERM_PREFIX/bin/termshark
}
