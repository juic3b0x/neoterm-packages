NEOTERM_PKG_HOMEPAGE=https://github.com/mvdan/sh
NEOTERM_PKG_DESCRIPTION="A shell parser and formatter"
NEOTERM_PKG_LICENSE="BSD 3-Clause"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="3.8.0"
NEOTERM_PKG_SRCURL=https://github.com/mvdan/sh/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=d8f28156a6ebfd36b68f5682b34ec7824bf61c3f3a38be64ad22e2fc2620bf44
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make_install() {
	cd "$NEOTERM_PKG_SRCDIR"

	neoterm_setup_golang

	export GOPATH="$NEOTERM_PKG_BUILDDIR"
	mkdir -p "$GOPATH/src/github.com/mvdan"
	ln -sf "$NEOTERM_PKG_SRCDIR" "$GOPATH/src/github.com/mvdan/sh"

	go build -modcacherw \
		-ldflags "-X main.version=$NEOTERM_PKG_VERSION" \
		-o "$NEOTERM_PREFIX/bin/shfmt" \
		./cmd/shfmt
}
