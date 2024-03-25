NEOTERM_PKG_HOMEPAGE=https://caddyserver.com/
NEOTERM_PKG_DESCRIPTION="Fast, cross-platform HTTP/2 web server"
NEOTERM_PKG_LICENSE="Apache-2.0"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION="2.7.6"
NEOTERM_PKG_SRCURL=https://github.com/caddyserver/caddy/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=e1c524fc4f4bd2b0d39df51679d9d065bb811e381b7e4e51466ba39a0083e3ed
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_golang
	export GOPATH=$NEOTERM_PKG_BUILDDIR

	mkdir -p $GOPATH/src/github.com/caddyserver/
	cp -a $NEOTERM_PKG_SRCDIR $GOPATH/src/github.com/caddyserver/caddy

	cd $GOPATH/src/github.com/caddyserver/caddy/cmd/caddy
	export GO111MODULE=on
	go build -v .
}

neoterm_step_make_install() {
	install -Dm700 -t $NEOTERM_PREFIX/bin $GOPATH/src/github.com/caddyserver/caddy/cmd/caddy/caddy
}
