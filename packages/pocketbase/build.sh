NEOTERM_PKG_HOMEPAGE=https://github.com/pocketbase/pocketbase
NEOTERM_PKG_DESCRIPTION="An open source Go backend"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="0.22.4"
NEOTERM_PKG_SRCURL="https://github.com/pocketbase/pocketbase/archive/refs/tags/v${NEOTERM_PKG_VERSION}.tar.gz"
NEOTERM_PKG_SHA256=9200b00828b5ea8345c147045577d5662b7e69ba743bba74d0c8ffc882ee3abc
NEOTERM_PKG_DEPENDS="resolv-conf"
NEOTERM_PKG_BUILD_IN_SRC=true
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_golang

	mkdir ./gopath
	export GOPATH="$PWD/gopath"

	cd $NEOTERM_PKG_SRCDIR/examples/base

	export GOBUILD=CGO_ENABLED=0

	go build \
		-trimpath \
		-o "pocketbase.bin" \
		main.go
}

neoterm_step_make_install() {
	install -m700 examples/base/pocketbase.bin "${NEOTERM_PREFIX}"/bin/pocketbase
}
