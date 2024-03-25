NEOTERM_PKG_HOMEPAGE=https://bitbucket.org/tmedwards/tweego
NEOTERM_PKG_DESCRIPTION="A free command line compiler for Twine/Twee story formats"
NEOTERM_PKG_LICENSE="BSD"
NEOTERM_PKG_MAINTAINER="@neoterm"
NEOTERM_PKG_VERSION=2.1.1
NEOTERM_PKG_REVISION=4
NEOTERM_PKG_SRCURL=https://github.com/tmedwards/tweego/archive/v$NEOTERM_PKG_VERSION.tar.gz
NEOTERM_PKG_SHA256=f58991ff0b5b344ebebb5677b7c21209823fa6d179397af4a831e5ef05f28b02
NEOTERM_PKG_AUTO_UPDATE=true

neoterm_step_make() {
	neoterm_setup_golang

	export GOPATH=$NEOTERM_PKG_BUILDDIR
	mkdir -p "$GOPATH"/src/github.com/tmedwards
	ln -sf "$NEOTERM_PKG_SRCDIR" "$GOPATH"/src/github.com/tmedwards/tweego

	cd "$GOPATH"/src/github.com/tmedwards/tweego
	go get -d -v github.com/tmedwards/tweego
	go build
}

neoterm_step_make_install() {
	install -Dm700 \
		"$GOPATH"/src/github.com/tmedwards/tweego/tweego \
		"$NEOTERM_PREFIX"/bin/
}
