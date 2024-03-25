NEOTERM_PKG_HOMEPAGE=https://github.com/asciimoo/wuzz
NEOTERM_PKG_DESCRIPTION="Interactive command line tool for HTTP inspection"
NEOTERM_PKG_LICENSE="AGPL-V3"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=0.5.0
NEOTERM_PKG_REVISION=4
NEOTERM_PKG_SRCURL=https://github.com/asciimoo/wuzz/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=721ea7343698e9f3c69e09eab86b9b1fef828057655f7cebc1de728c2f75151e
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_golang

	export GOPATH=$NEOTERM_PKG_BUILDDIR
	mkdir -p "$GOPATH"/src/github.com/asciimoo
	ln -sf "$NEOTERM_PKG_SRCDIR" "$GOPATH"/src/github.com/asciimoo/wuzz

	cd "$GOPATH"/src/github.com/asciimoo/wuzz
	go mod download github.com/BurntSushi/toml
	go get github.com/asciimoo/wuzz
	go build
}

neoterm_step_make_install() {
	install -Dm700 \
		"$GOPATH"/src/github.com/asciimoo/wuzz/wuzz \
		"$NEOTERM_PREFIX"/bin/wuzz
}
