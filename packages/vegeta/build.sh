NEOTERM_PKG_HOMEPAGE=https://github.com/tsenart/vegeta
NEOTERM_PKG_DESCRIPTION="HTTP load testing tool"
NEOTERM_PKG_LICENSE="MIT"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="12.11.1"
NEOTERM_PKG_SRCURL=https://github.com/tsenart/vegeta/archive/v${NEOTERM_PKG_VERSION}.tar.gz
NEOTERM_PKG_SHA256=e3e65be2c79195aab39384faf15950c2c2fd61f228f6c9255c99611ac6c8f329
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_golang

	export GOPATH=$NEOTERM_PKG_BUILDDIR
	mkdir -p "$GOPATH"/src/github.com/tsenart
	ln -sf "$NEOTERM_PKG_SRCDIR" "$GOPATH"/src/github.com/tsenart/vegeta

	cd "$GOPATH"/src/github.com/tsenart/vegeta
	go build
}

neoterm_step_make_install() {
	install -Dm700 \
		"$GOPATH"/src/github.com/tsenart/vegeta/vegeta \
		"$NEOTERM_PREFIX"/bin/vegeta
}
